# Description:
#   A Hubot script for displaying the random words from www.weblio.jp.
#
# Configuration:
#   None
#
# Commands:
#   hubot randict - display the random words from www.weblio.jp
#
# Author:
#   bouzuya <m@bouzuya.net>
#
cheerio = require 'cheerio'

module.exports = (robot) ->

  # options: { http }
  # callback: function(err, { url, word })
  random = (options, callback) ->
    options
      .http 'http://www.weblio.jp/WeblioRandomSelectServlet'
      .get() (err, resp) ->
        return callback(err) if err?
        url = resp.headers.location
        pattern = /^http:\/\/www\.weblio\.jp\/content\//
        word = decodeURI url?.replace(pattern, '')
        callback(null, {url, word})

  # options: { url, word, http }
  # callback: function(err, { url, word, description? })
  description = (options, callback) ->
    options
      .http options.url
      .get() (err, _, body) ->
        return callback(err, options) if err?
        $ = cheerio.load body
        # quote meta characters
        quoted = options.word.replace(/([.*+?^${}()|\[\]\/\\])/g, "\\$1")
        desc = $ 'meta[name="description"]'
          .attr 'content'
          .replace /&nbsp;/g, ''
          .replace new RegExp('^' + quoted + 'とは\\?'), ''
        callback null,
          url: options.url
          word: options.word
          description: desc

  robot.respond /randict$/i, (res) ->
    random {
      http: res.http.bind(res)
    }, (err, result) ->
      return robot.logger.error(err) if err?
      description {
        http: res.http.bind(res)
        url: result.url
        word: result.word
      }, (err, result) ->
        return res.send(result.word + '\n' + result.url) if err?
        res.send result.word + ' - ' + result.description + '\n' + result.url

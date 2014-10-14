// Description:
//   A Hubot script for displaying the random words from www.weblio.jp.
//
// Configuration:
//   None
//
// Commands:
//   hubot randict - display the random words from www.weblio.jp
//
// Author:
//   bouzuya <m@bouzuya.net>
//
var cheerio;

cheerio = require('cheerio');

module.exports = function(robot) {
  var description, random;
  random = function(options, callback) {
    return options.http('http://www.weblio.jp/WeblioRandomSelectServlet').get()(function(err, resp) {
      var pattern, url, word;
      if (err != null) {
        return callback(err);
      }
      url = resp.headers.location;
      pattern = /^http:\/\/www\.weblio\.jp\/content\//;
      word = decodeURI(url != null ? url.replace(pattern, '') : void 0);
      return callback(null, {
        url: url,
        word: word
      });
    });
  };
  description = function(options, callback) {
    return options.http(options.url).get()(function(err, _, body) {
      var $, desc, quoted;
      if (err != null) {
        return callback(err, options);
      }
      $ = cheerio.load(body);
      quoted = options.word.replace(/([.*+?^${}()|\[\]\/\\])/g, "\\$1");
      desc = $('meta[name="description"]').attr('content').replace(/&nbsp;/g, '').replace(new RegExp('^' + quoted + 'とは\\?'), '');
      return callback(null, {
        url: options.url,
        word: options.word,
        description: desc
      });
    });
  };
  return robot.respond(/randict$/i, function(res) {
    return random({
      http: res.http.bind(res)
    }, function(err, result) {
      if (err != null) {
        return robot.logger.error(err);
      }
      return description({
        http: res.http.bind(res),
        url: result.url,
        word: result.word
      }, function(err, result) {
        if (err != null) {
          return res.send(result.word + '\n' + result.url);
        }
        return res.send(result.word + ' - ' + result.description + '\n' + result.url);
      });
    });
  });
};

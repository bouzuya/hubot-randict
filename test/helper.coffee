global.expect = require('chai').use(require('sinon-chai')).expect
sinon = require 'sinon'

beforeEach ->
  @sinon = sinon.sandbox.create()

afterEach ->
  @sinon.restore()

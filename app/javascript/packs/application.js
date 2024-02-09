// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@popperjs/core")
global.$ = require("jquery")
import Rails from "@rails/ujs"
import {createConsumer} from "@rails/actioncable";
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'channels'
import 'jquery'
import 'bootstrap'
//= require skim
import '../vote'
import '../answers'
import '../comments'
import '../questions'
require("../stylesheets/application.scss")

export default createConsumer()
require("../stylesheets/application.scss")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

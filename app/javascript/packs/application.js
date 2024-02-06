// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@popperjs/core")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'bootstrap-icons/font/bootstrap-icons.css'
import 'jquery'
import 'bootstrap'
import 'channels'
import 'skim'
import '../vote'
import '../answers'
import '../comments'
import '../questions'
require("../stylesheets/application.scss")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

var App = App || {};
App.cable = ActionCable.createConsumer();

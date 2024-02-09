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
import 'bootstrap'
import { Tooltip, Popover } from "bootstrap"
//= require skim
import '../vote'
import '../answers'
import '../comments'
import '../questions'

export default createConsumer()
require("../stylesheets/application.scss")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", () => {
    // Both of these are from the Bootstrap 5 docs
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl)
    })

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new Popover(popoverTriggerEl)
    })
})

let App = App || {}
App.cable = createConsumer()

App.cable.subscriptions.create('AnswersChannel', {
    connected: function () {
        let question_id = gon.question_id;
        return this.perform('follow', {question_id: question_id});
    },
    received: function (data) {
        if (gon.user_id !== data.answer.user_id) {
            $('.answers').append(JST['templates/answer']({
                answer: data.answer,
                links: data.links,
                rating: data.rating
            }));
        }
    }
})

App.cable.subscriptions.create('CommentsChannel', {
    connected:function () {
        let question_id = gon.question_id;
        return this.perform('follow', { question_id: question_id });
    },
    received: function (data) {
        if (gon.user_id !== data.comment.user_id) {
            let resourceName = data.comment.commentable_type,
                resourceId = data.comment.commentable_id,
                newComment = JST['templates/comment']({comment: data.comment});

            if (resourceName === 'Question') {
                $(`#question_${resourceId} .comments`).append(newComment);
            } else if (resourceName === 'Answer') {
                $(`#answer_${resourceId} .comments`).append(newComment);
            }
        }
    }
})

App.cable.subscriptions.create('QuestionsChannel', {
    connected: function () {
        return this.perform('follow');
    },
    received: function (data) {
        $('.questions').append(JST['templates/question'](data));
    }
})

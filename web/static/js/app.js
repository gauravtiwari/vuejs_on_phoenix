// Import dependencies
import "phoenix_html"
import 'turbolinks'
import Vue from "vue";
import $ from 'jquery';

// Import local files
// import socket from "./socket"

function mountComponents() {
  const components = document.querySelectorAll('[data-behaviour="component"]');
  for (let i = 0; i < components.length; i++) {
    const node = components[i]
    const props = JSON.parse(node.getAttribute('data-props'));

    new Vue({
      el: node,
      data: props,
      methods: {
        addComment: function() {
          $.ajax({
            type: 'post',
            url: '/posts/' + this.newComment.post_id + '/comment',
            dataType: 'json',
            data: { comment: this.newComment },
            success: function(data, textStatus, xhr) {
              if (data) {
                // Add it to top
                this.comments.unshift({
                  body: data.body,
                  id: data.id
                });

                // Setup empty new comment object
                this.newComment = {
                  body: '',
                  post_id: this.newComment.post_id
                }
              }
            }.bind(this)
          })
        },
      }
    })
  }
}

// Use turbolinks
document.addEventListener('DOMContentLoaded', () => {
  $.ajaxSetup({
    headers: { 'X-CSRF-TOKEN': document.querySelector("meta[name=csrf]").content }
  });
  if (!(typeof Turbolinks !== 'undefined')) {
    mountComponents();
  } else {
    if (typeof Turbolinks.controller !== 'undefined') {
      document.addEventListener('turbolinks:load', mountComponents);
    } else {
      document.addEventListener('page:change', mountComponents);
    }
  }
});



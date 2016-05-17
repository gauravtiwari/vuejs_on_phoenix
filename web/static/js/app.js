// Import dependencies
import "phoenix_html"
import 'turbolinks'
import Vue from "vue";
import $ from 'jquery';

// Import local files
import socket from "./socket"

function mountComponents() {
  const components = document.querySelectorAll('[data-behaviour="component"]');
  for (let i = 0; i < components.length; i++) {
    const node = components[i]
    const props = JSON.parse(node.getAttribute('data-props'));
    const $vue = new Vue({
      el: node,
      data: props,
      methods: {
        addComment: function() {
          $.ajax({
            type: 'post',
            url: '/posts/' + props.post_id + '/comment',
            dataType: 'json',
            data: { comment: { body: this.newComment.body, post_id: props.post_id } },
            success: function(data, textStatus, xhr) {
              if (data) {
                // Add it to the top
                this.comments.unshift({
                  body: data.body,
                  id: data.id
                });

                // Setup empty new comment object
                this.newComment = {
                  body: '',
                  post_id: props.post_id
                }
              }
            }.bind(this)
          })
        },
      }
    });

    if(props.post_id) {
      const commentsChannel = `comments:${props.post_id}`;

      const channel = socket.channel(
        commentsChannel
      );

      channel.join()
      .receive("ok", data => {
        console.log("Joined comments channel for", commentsChannel);
      })
      .receive("error", resp => {
        console.log("Unable to join comments channel for", commentsChannel);
      });

      console.log(parseInt(window.currentUserId) != socket.params.user_id);

      channel.on('new_comment', comment => {
        if(parseInt(window.currentUserId) != socket.params.user_id) {
          $vue.$data.comments.unshift({
            body: comment.body,
            post_id: comment.post_id,
            id: comment.id
          });
        }
      });
    }
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

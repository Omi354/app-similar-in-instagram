// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

$(document).on('turbolinks:load', () => {
  $('.post-index').each(function() {
    const dataset = $(this).data()
    const postId = dataset.postId
    axios.get(`/posts/${postId}/like`)
    .then(response => {
      if (response.data.has_like === true) {
        $(`#unlikeBtn_${postId}`).removeClass('hidden')
        $(`#likeBtn_${postId}`).addClass('hidden')
      } else {
        $(`#unlikeBtn_${postId}`).addClass('hidden')
        $(`#likeBtn_${postId}`).removeClass('hidden')
      }
    })
  })
})




// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

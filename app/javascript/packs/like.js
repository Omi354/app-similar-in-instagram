import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()



$(document).on('turbolinks:load', () => {
  $('.post-index').each(function() {    //hamlの繰り返しに対応して、eachの繰り返し処理を行う
    const dataset = $(this).data()
    const postId = dataset.postId

    axios.get(`/api/posts/${postId}/like`)
    .then(response => {
      if (response.data.has_like === true) {
        $(`#unlikeBtn_${postId}`).removeClass('hidden')
        $(`#likeBtn_${postId}`).addClass('hidden')
      } else {
        $(`#unlikeBtn_${postId}`).addClass('hidden')
        $(`#likeBtn_${postId}`).removeClass('hidden')
      }
    })

    $(`#likeBtn_${postId}`).on('click', () => {
      axios.post(`/api/posts/${postId}/like`)
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

    $(`#unlikeBtn_${postId}`).on('click', () => {
      axios.delete(`/api/posts/${postId}/like`)
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
})

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

$(document).on('turbolinks:load', () => {
  $('.commentBtn').on('click', () => {
    $('.commentArea').toggleClass('hidden')
  })

  $('#submitComment').on('click', () => {
    const postId = $('#commentTitle').data('post-id')
    const comment = $('#commentArea').val()
    if (comment === '') {
      alert('comment cannot be blank')
      return
    }

    const formData = new FormData()
    formData.append('comment[content]', comment)
    formData.append('comment[post_id]', postId)
    axios.post(`/posts/${postId}/comments`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
    .then(response => {
      if(response.data['msg'] === 'ok') {
        console.log('Done!')
      }
    })
  })

})
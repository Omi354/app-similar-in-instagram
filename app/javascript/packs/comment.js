import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


$(document).ready(() => {
  const postId = $('#commentTitle').data('post-id')
  axios.get(`/api/posts/${postId}/comments`)
  .then(response => {
    const comments = response.data
    comments.forEach(comment => {
      const commentHtml = `
        <div class="postedUser">
          <img class="postedUser_avatar" src="${comment.user.profile.avatar_url}" alt="User Avatar">
          <div class="postedUser_textContainer">
            <p class="postedUser_username">${comment.user.username}</p>
            <p class="postedUser_comment">${comment.content}</p>
        </div>
      `
      $('.comments-container').append(commentHtml)
    })
  })
  .catch(error => {
    console.error('Error fetching comments:', error)
  })

  $('.commentBtn').on('click', () => {
    $('.commentArea').toggleClass('hidden')
  })


  $('#submitComment').on('click', () => {
    const comment = $('#commentArea').val()
    if (comment === '') {
      alert('comment cannot be blank')
      return
    }

    const formData = new FormData()
    formData.append('comment[content]', comment)
    formData.append('comment[post_id]', postId)
    axios.post(`/api/posts/${postId}/comments`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
    .then(response => {
      const comment = response.data
      const commentHtml = `
        <div class="postedUser">
          <img class="postedUser_avatar" src="${comment.user.profile.avatar_url}" alt="User Avatar">
          <div class="postedUser_textContainer">
            <p class="postedUser_username">${comment.user.username}</p>
            <p class="postedUser_comment">${comment.content}</p>
        </div>
      `
      $('.comments-container').append(commentHtml)
      $('.commentArea').toggleClass('hidden')
      $('.commentArea').val('')
    })
  })
})
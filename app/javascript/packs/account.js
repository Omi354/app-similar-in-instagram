import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleFollowBtn = (followingId) => {
  // current_userがaccount_idの人をフォローしているかどうかを判断
  axios.get(`/accounts/${followingId}/follow`)
  .then(response => {
    if (response.data.follow) {
      // unfollowを表示するためのremove,addの処理
      $('#followBtn').addClass('hidden')
      $('#unfollowBtn').removeClass('hidden')
    } else {
      // followを表示するためのremove,addの処理
      $('#followBtn').removeClass('hidden')
      $('#unfollowBtn').addClass('hidden')
    }
  })
}

const createFollow = (followingId) => {
  $('#followBtn').on('click', () => {
    axios.post(`/accounts/${followingId}/follow`, {
      following_id: followingId
    })
    .then(response => {
      window.alert(response.data['msg'])

      let count = parseInt($('#followersCount').text())
      $('#followersCount').text(count + 1)

      handleFollowBtn(followingId)
    })
    .catch(error => {
      window.alert('フォローに失敗しました')
    })
  })
}

const createUnfollow = (followingId) => {
  $('#unfollowBtn').on('click', () => {
    axios.post(`/accounts/${followingId}/unfollow`, {
      following_id: followingId
    })
    .then(response => {
      window.alert(response.data['msg'])

      let count = parseInt($('#followersCount').text())
      $('#followersCount').text(count - 1)

      handleFollowBtn(followingId)
    })
  })
}

$(document).ready(() => {
  const followingId = $('.userName').data('followingId')
  handleFollowBtn(followingId)
  createFollow(followingId)
  createUnfollow(followingId)

})
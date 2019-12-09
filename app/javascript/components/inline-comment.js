const onLinkClicked = (event) => {
  event.preventDefault()
  // Find the form
  const parent = event.target.closest('.comment-container')
  const form = parent.querySelector('.reply-comment-form')
  // toggle its visibility
  form.classList.toggle('d-none')
}

const setupInlineComments = () => {
  // find all reply links
  const replyLinks = document.querySelectorAll('.reply-link')
  replyLinks.forEach((link) => {
    link.addEventListener('click', onLinkClicked)
  })
}


export { setupInlineComments }

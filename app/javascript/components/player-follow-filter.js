const matchesFilter = (text, element) => {
  const firstName = element.dataset.personFirstName.toLowerCase()
  const lastName = element.dataset.personLastName.toLowerCase()
  text = text.toLowerCase()

  return (firstName.indexOf(text) === 0) ||
    (lastName.indexOf(text) === 0)
}

const onFilterChange = () => {
  const input = document.getElementById('player-follow-filter')
  const filter = input.value.trim()

  // find all players
  const playerDivs = document.querySelectorAll('[data-person-first-name]')
  playerDivs.forEach((playerDiv) => {
    // hide each player that does not match the filter
    if (matchesFilter(filter, playerDiv)) {
      playerDiv.classList.remove('d-none')
    } else {
      playerDiv.classList.add('d-none')
    }
  })
}


const setupPlayerFollowFilter = () => {
  // Find the input controller
  const input = document.getElementById('player-follow-filter')
  input.addEventListener('keyup', onFilterChange)
  input.addEventListener('change', onFilterChange)
}

export { setupPlayerFollowFilter }

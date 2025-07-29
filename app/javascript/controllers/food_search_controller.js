import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hiddenField", "results"]
  static values = { url: String }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.performSearch()
    }, 300) // Debounce for 300ms
  }

  async performSearch() {
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.clearResults()
      return
    }

    try {
      const response = await fetch(`${this.urlValue}?q=${encodeURIComponent(query)}`, {
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (!response.ok) throw new Error('Network response was not ok')

      const food = await response.json()
      this.handleSearchResult(food)

    } catch (error) {
      console.error('Food search error:', error)
      this.showError('Error searching for food')
    }
  }

  handleSearchResult(food) {
    if (food && food.id) {
      this.hiddenFieldTarget.value = food.id
      this.inputTarget.value = food.name
      this.showSuccess(`Found: ${food.name} (${food.calories_per_100g} cal/100g)`)
    } else {
      this.hiddenFieldTarget.value = ''
      this.showError('Food not found')
    }
  }

  showSuccess(message) {
    if (this.hasResultsTarget) {
      this.resultsTarget.innerHTML = `<div class="search-success">${message}</div>`
      this.hideResultsAfterDelay()
    }
  }

  showError(message) {
    if (this.hasResultsTarget) {
      this.resultsTarget.innerHTML = `<div class="search-error">${message}</div>`
      this.hideResultsAfterDelay()
    }
  }

  clearResults() {
    if (this.hasResultsTarget) {
      this.resultsTarget.innerHTML = ''
    }
  }

  hideResultsAfterDelay() {
    setTimeout(() => {
      this.clearResults()
    }, 3000)
  }

  selectFood(event) {
    event.preventDefault()
    const foodId = event.target.dataset.foodId
    const foodName = event.target.dataset.foodName
    const calories = event.target.dataset.calories

    this.hiddenFieldTarget.value = foodId
    this.inputTarget.value = foodName
    this.showSuccess(`Selected: ${foodName} (${calories} cal/100g)`)
  }
}

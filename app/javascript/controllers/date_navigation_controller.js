import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateDisplay"]
  static values = { currentDate: String }

  goToToday(event) {
    event.preventDefault()
    const today = new Date().toISOString().split('T')[0]
    this.navigateToDate(today)
  }

  previousDay(event) {
    event.preventDefault()
    const currentDate = new Date(this.currentDateValue)
    currentDate.setDate(currentDate.getDate() - 1)
    this.navigateToDate(currentDate.toISOString().split('T')[0])
  }

  nextDay(event) {
    event.preventDefault()
    const currentDate = new Date(this.currentDateValue)
    currentDate.setDate(currentDate.getDate() + 1)
    this.navigateToDate(currentDate.toISOString().split('T')[0])
  }

  navigateToDate(dateString) {
    const url = new URL(window.location)
    url.searchParams.set('date', dateString)
    window.location.href = url.toString()
  }

  formatDate(dateString) {
    const date = new Date(dateString)
    return date.toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  static values = { index: Number }

  connect() {
    this.indexValue = this.containerTarget.children.length
  }

  addIngredient(event) {
    event.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, this.indexValue)
    this.containerTarget.insertAdjacentHTML('beforeend', content)
    this.indexValue++
  }

  removeIngredient(event) {
    event.preventDefault()

    const ingredientRow = event.target.closest('[data-ingredient-row]')
    const destroyInput = ingredientRow.querySelector('input[name*="_destroy"]')

    if (destroyInput) {
      // If this is an existing record, mark for destruction
      destroyInput.value = '1'
      ingredientRow.style.display = 'none'
    } else {
      // If this is a new record, remove from DOM
      ingredientRow.remove()
    }
  }
}

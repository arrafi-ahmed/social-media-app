export default class SubscriptionPlan {
  constructor ({ id = null, title = '', tagline = '', price = 0, currency = 'GBP', lookupKey = '' } = {}) {
    this.id = id
    this.title = title
    this.tagline = tagline
    this.price = price
    this.currency = currency
    this.lookupKey = lookupKey
  }
}

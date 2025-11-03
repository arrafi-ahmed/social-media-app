export default class Subscription {
  constructor ({
                id = null,
                userId = null,
                planId = null,
                stripeSubscriptionId = '',
                subscriptionAmount = 0,
                activationDate = null,
                expireDate = null,
                active = false,
                pendingCancel = false,
                createdAt = null,
              } = {}) {
    this.id = id
    this.userId = userId
    this.planId = planId
    this.stripeSubscriptionId = stripeSubscriptionId
    this.subscriptionAmount = subscriptionAmount
    this.activationDate = activationDate
    this.expireDate = expireDate
    this.active = active
    this.pendingCancel = pendingCancel
    this.createdAt = createdAt
  }
}

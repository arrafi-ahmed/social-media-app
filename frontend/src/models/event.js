export default class Event {
  constructor ({
                id = null,
                title = '',
                date = null,
                startTime = null,
                endTime = null,
                location = '',
                description = '',
                category = '',
                images = [],
                isFeatured = false,
                newNotification = false,
                userId = null,
                createdAt = null,
                expiresAt = null,
                reactions = { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 },
                userReaction = null,
              } = {}) {
    this.id = id
    this.title = title
    this.date = date
    this.startTime = startTime
    this.endTime = endTime
    this.location = location
    this.description = description
    this.category = category
    this.images = images
    this.isFeatured = isFeatured
    this.newNotification = newNotification
    this.userId = userId
    this.createdAt = createdAt
    this.expiresAt = expiresAt
    this.reactions = reactions
    this.userReaction = userReaction
  }
}

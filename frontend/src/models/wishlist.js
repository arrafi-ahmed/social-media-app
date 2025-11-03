export default class Wishlist {
  constructor ({
                id = null,
                title = '',
                location = '',
                description = '',
                category = '',
                images = [],
                userId = null,
                createdAt = null,
              } = {}) {
    this.id = id
    this.title = title
    this.location = location
    this.description = description
    this.category = category
    this.images = images
    this.userId = userId
    this.createdAt = createdAt
  }
}

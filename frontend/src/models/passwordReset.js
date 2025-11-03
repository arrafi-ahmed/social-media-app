export default class PasswordReset {
  constructor ({ id = null, email = '', token = '', createdAt = null } = {}) {
    this.id = id
    this.email = email
    this.token = token
    this.createdAt = createdAt
  }
}

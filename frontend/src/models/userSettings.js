export default class UserSettings {
  constructor ({
                id = null,
                emailNewEventNotification = true,
                emailUpdateEventNotification = true,
                emailNewCommentNotification = true,
                sort = 'LATEST',
                theme = 'light',
                userId = null,
              } = {}) {
    this.id = id
    this.emailNewEventNotification = emailNewEventNotification
    this.emailUpdateEventNotification = emailUpdateEventNotification
    this.emailNewCommentNotification = emailNewCommentNotification
    this.sort = sort
    this.theme = theme
    this.userId = userId
  }
}

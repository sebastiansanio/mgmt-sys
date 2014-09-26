package mgmt.security

import org.apache.commons.lang.builder.HashCodeBuilder

class SecUserSecAuthority implements Serializable {

	private static final long serialVersionUID = 1

	SecUser secUser
	SecAuthority secAuthority

	boolean equals(other) {
		if (!(other instanceof SecUserSecAuthority)) {
			return false
		}

		other.secUser?.id == secUser?.id &&
		other.secAuthority?.id == secAuthority?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (secUser) builder.append(secUser.id)
		if (secAuthority) builder.append(secAuthority.id)
		builder.toHashCode()
	}

	static SecUserSecAuthority get(long secUserId, long secAuthorityId) {
		SecUserSecAuthority.where {
			secUser == SecUser.load(secUserId) &&
			secAuthority == SecAuthority.load(secAuthorityId)
		}.get()
	}

	static boolean exists(long secUserId, long secAuthorityId) {
		SecUserSecAuthority.where {
			secUser == SecUser.load(secUserId) &&
			secAuthority == SecAuthority.load(secAuthorityId)
		}.count() > 0
	}

	static SecUserSecAuthority create(SecUser secUser, SecAuthority secAuthority, boolean flush = false) {
		def instance = new SecUserSecAuthority(secUser: secUser, secAuthority: secAuthority)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(SecUser u, SecAuthority r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = SecUserSecAuthority.where {
			secUser == SecUser.load(u.id) &&
			secAuthority == SecAuthority.load(r.id)
		}.deleteAll()

		if (flush) { SecUserSecAuthority.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(SecUser u, boolean flush = false) {
		if (u == null) return

		SecUserSecAuthority.where {
			secUser == SecUser.load(u.id)
		}.deleteAll()

		if (flush) { SecUserSecAuthority.withSession { it.flush() } }
	}

	static void removeAll(SecAuthority r, boolean flush = false) {
		if (r == null) return

		SecUserSecAuthority.where {
			secAuthority == SecAuthority.load(r.id)
		}.deleteAll()

		if (flush) { SecUserSecAuthority.withSession { it.flush() } }
	}

	static constraints = {
		secAuthority validator: { SecAuthority r, SecUserSecAuthority ur ->
			if (ur.secUser == null) return
			boolean existing = false
			SecUserSecAuthority.withNewSession {
				existing = SecUserSecAuthority.exists(ur.secUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['secAuthority', 'secUser']
		version false
	}
}

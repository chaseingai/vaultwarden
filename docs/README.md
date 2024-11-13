# 🚀 Vaultwarden Configuration Guide

This guide will help you set up Vaultwarden on Railway with an optimized and secure environment configuration. Each setting below is explained to help you choose what works best for your needs.

---

## Basic Configuration

### 1. **ROCKET_PORT**
   - **Description**: Specifies the port Vaultwarden will use.
   - **Default**: `80`
   - **Example**: `ROCKET_PORT=80`

### 2. **I_REALLY_WANT_VOLATILE_STORAGE**
   - **Description**: Controls whether volatile storage is allowed. By setting this to `false`, you will be reminded to configure a persistent volume to avoid data loss.
   - **Default**: `false`
   - **Example**: `I_REALLY_WANT_VOLATILE_STORAGE=false`

### 3. **DATABASE_URL**
   - **Description**: Connects Vaultwarden to a PostgreSQL database. This is highly recommended for production deployments. Railway can create this automatically if you add a PostgreSQL plugin.
   - **Format**: `postgresql://user:password@host:port/database`
   - **Example**: `DATABASE_URL=postgresql://username:password@host:5432/vaultwarden_db`

### 4. **ADMIN_TOKEN**
   - **Description**: Sets a secure token for accessing the admin panel. It’s best to use an Argon2 hashed string for security.
   - **Example**: `ADMIN_TOKEN=$(vaultwarden hash $(openssl rand -base64 16))`

---

## Additional Configuration Options

### 5. **DOMAIN**
   - **Description**: Sets the domain where Vaultwarden is accessible. Required for certain features to function properly, like email links and downloads.
   - **Example**: `DOMAIN=https://yourdomain.com`

### 6. **SMTP Configuration for Email Notifications**
   - **Description**: Enables email notifications for 2FA, verification, and admin alerts. Configure SMTP if you plan to use email-based features.
   - **Settings**:
      - `SMTP_HOST`: Your SMTP server (e.g., `smtp.domain.com`)
      - `SMTP_FROM`: Sender email for notifications (e.g., `vaultwarden@domain.com`)
      - `SMTP_PORT`: Port for SMTP; typically `587` for STARTTLS or `465` for SSL.
      - `SMTP_SECURITY`: Choose `"starttls"`, `"force_tls"`, or `"off"` for encryption.
   - **Example**:
     ```env
     SMTP_HOST=smtp.domain.com
     SMTP_FROM=vaultwarden@domain.com
     SMTP_PORT=587
     SMTP_SECURITY=starttls
     ```

### 7. **SIGNUPS_ALLOWED**
   - **Description**: Controls whether new users can register themselves.
   - **Default**: `true`
   - **Example**: `SIGNUPS_ALLOWED=true`

### 8. **SIGNUPS_VERIFY**
   - **Description**: Requires email verification upon signup, adding an extra layer of security.
   - **Default**: `false`
   - **Example**: `SIGNUPS_VERIFY=true`

---

## Advanced Features and Security

### 9. **PUSH_ENABLED**
   - **Description**: Enables push notifications for mobile clients. Requires an installation ID and key from Bitwarden.
   - **Settings**:
     - `PUSH_INSTALLATION_ID`: Provided by Bitwarden.
     - `PUSH_INSTALLATION_KEY`: Provided by Bitwarden.
   - **Example**:
     ```env
     PUSH_ENABLED=true
     PUSH_INSTALLATION_ID=YourInstallationID
     PUSH_INSTALLATION_KEY=YourInstallationKey
     ```

### 10. **ENABLE_WEBSOCKET**
   - **Description**: Enables WebSocket support for real-time notifications in the web vault.
   - **Default**: `false`
   - **Example**: `ENABLE_WEBSOCKET=true`

---

## Database Optimization

### 11. **DATABASE_MAX_CONNS**
   - **Description**: Sets the maximum number of database connections. This can improve performance if your database is under heavy load.
   - **Default**: `10`
   - **Example**: `DATABASE_MAX_CONNS=10`

---

## Additional Security Settings

### 12. **2FA Configuration (Duo Security)**
   - **Description**: Integrates with Duo Security for two-factor authentication.
   - **Settings**:
     - `DUO_IKEY`: Your Duo integration key.
     - `DUO_SKEY`: Your Duo secret key.
     - `DUO_HOST`: Your Duo API hostname.
   - **Example**:
     ```env
     DUO_IKEY=YourDuoIntegrationKey
     DUO_SKEY=YourDuoSecretKey
     DUO_HOST=YourDuoAPIHostname
     ```

### 13. **Attachment Storage Limits**
   - **Description**: Sets storage limits for attachments per user or organization.
   - **Settings**:
      - `ORG_ATTACHMENT_LIMIT`: Attachment limit per organization (in KB).
      - `USER_ATTACHMENT_LIMIT`: Attachment limit per user (in KB).
   - **Example**:
     ```env
     ORG_ATTACHMENT_LIMIT=102400 # 100 MB
     USER_ATTACHMENT_LIMIT=51200  # 50 MB
     ```

---

## Setting Up the Persistent Volume on Railway

To ensure data persists across redeployments, add a persistent volume on Railway:

1. Go to your Vaultwarden project on Railway.
2. In the **Settings** tab, locate the **Persistent Volume** section.
3. Set the volume mount path to `/data` to store the Vaultwarden database and configurations.

---

# Reporting App

This repository contains a Reporting App designed with a robust three-layer security system. The app ensures secure access and data retrieval by implementing the following steps:

1. **Initial Key Setup**:
   - Upon first run, the app checks for a key in the local database.
   - If the key is not found, the app prompts the user to input an alphanumeric key.
   - The provided key is then stored in the local database on the mobile device.

2. **URL Construction and Redirection**:
   - The app concatenates the stored key to a base URL, forming a complete URL.
   - This constructed URL is redirected internally to obtain a response string containing necessary credentials.

3. **Credentials Extraction**:
   - The response string contains the username and password for the Oracle database.
   - The username is highlighted within the string, and the password is included in reverse order.
   - The app reverses the password characters to obtain the correct password.

4. **Database Connection**:
   - The app uses the extracted credentials to log into the Oracle database at a specified IP and port.
   - Once connected, the app retrieves the application title by running a specific query.

5. **Displaying the Title**:
   - The app displays the retrieved title on the main page header (e.g., "Welcome Industry App").

This multi-layered security approach ensures that only authorized users can access the sensitive data within the app, providing a secure and efficient reporting solution.

Feel free to explore the code and contribute!

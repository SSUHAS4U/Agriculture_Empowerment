# Agriculture Empowerment Project

This project is an Agriculture Empowerment web application built using Java, JSP, and MySQL. It provides a platform for users to browse and purchase agriculture products, promoting support for the agricultural community.

## Features

- **Browse Products**: View available agriculture products with details such as name, description, quantity, and price.
- **Add to Cart**: Add products to the shopping cart for purchase.
- **User Authentication**: Secure login and registration.
- **Admin Panel**: Admins can manage inventory, including adding, updating, and deleting products.
- **Order Management**: Track user orders.

## Technologies Used

- **Frontend**: JSP (JavaServer Pages), HTML, CSS, JavaScript
- **Backend**: Java, Servlet, JSP
- **Database**: MySQL
- **Server**: JBoss 7.1
- **Development Tools**:
  - MySQL Workbench for database management
  - Eclipse or IntelliJ IDEA for Java development

## Prerequisites

- JDK 8 or later
- JBoss AS 7.1
- MySQL 5.7 or later
- MySQL Workbench (optional, for database management)

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/agriculture-empowerment.git
   ```

2. **Configure the Database**:
   - Create a database named `agriculture`.
   - Run the provided SQL scripts in the `database` folder to set up tables and initial data.

3. **Update Database Configuration**:
   - Update the database connection details in `dbconfig.jsp`:
     ```java
     String url = "jdbc:mysql://localhost:3306/agriculture";
     String username = "your_db_username";
     String password = "your_db_password";
     ```

4. **Deploy on JBoss**:
   - Configure JBoss 7.1 and deploy the application by copying the project’s WAR file to the `standalone/deployments` directory.
   - Start the JBoss server and access the application at `http://localhost:8080/agriculture-empowerment`.

## Directory Structure

- **/src**: Java source files
- **/WebContent**: JSP files, CSS, and JavaScript files
- **/database**: SQL scripts for setting up the database
- **/lib**: External libraries (JAR files)

## Future Enhancements

- Integrate payment gateways for online transactions.
- Add product reviews and ratings.
- Implement a recommendation system for related products.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

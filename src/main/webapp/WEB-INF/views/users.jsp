<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.online.quiz.model.Users" %>
<%@ page import="com.online.quiz.model.UserRole" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - User Management</title>
    <style>
        /* Basic styling for layout */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        .search-form {
            padding: 20px;
            background-color: #f4f4f4;
            border-bottom: 1px solid #ddd;
        }
        .search-form label {
            margin-right: 10px;
            font-weight: bold;
        }
        .search-form input, .search-form select, .search-form button {
            padding: 5px;
            margin-right: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .action-link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }
        /* Modal styling */
        #editRoleModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            width: 300px;
            margin: 100px auto;
            position: relative;
        }
        .modal-content h2 {
            margin-top: 0;
        }
        .modal-content label {
            display: block;
            margin-bottom: 10px;
        }
        .modal-content button {
            padding: 5px 10px;
            margin: 5px;
        }
        /* Utility classes */
        .text-center {
            text-align: center;
        }
        .text-right {
            text-align: right;
        }
        
        .main-content {
            margin-left: 250px; 
            padding: 70px 20px 20px; /* Adjusted for navbar height */
        }

        .main-content h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />
<jsp:include page="sidebar.jsp" />

<div class="main-content">
    <h2>User Management</h2>

    <!-- Search Form -->
    <div class="search-form">
        <label for="role">Role:</label>
        <select id="role">
            <option value="">All</option>
            <option value="Admin">Admin</option>
            <option value="User">User</option>
        </select>

        <label for="name">Name:</label>
        <input type="text" id="name" placeholder="Enter name">

        <label for="email">Email:</label>
        <input type="text" id="email" placeholder="Enter email">

        <button onclick="fetchUsers()">Search</button>
    </div>

    <!-- User Table -->
    <div id="userTable">
        <table>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
            <% 
                List<Users> users = (List<Users>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (Users user : users) { 
                        String roles = "";
                        for (UserRole userRole : user.getUserRoles()) {
                            if (roles.isEmpty()) {
                                roles = userRole.getRole().getRoleName();
                            } else {
                                roles += ", " + userRole.getRole().getRoleName();
                            }
                        }
            %>
                    <tr>
                        <td><%= user.getUserID() %></td>
                        <td><%= user.getFullName() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= roles %></td>
                        <td><a class="action-link" href="#" onclick="editUserRole(<%= user.getUserID() %>)">Edit Role</a></td>
                    </tr>
            <% 
                    }
                } else { 
            %>
                    <tr>
                        <td colspan="5" class="text-center">No users found.</td>
                    </tr>
            <% 
                } 
            %>
        </table>
    </div>
</div>

<!-- Edit Role Modal -->
<div id="editRoleModal">
    <div class="modal-content">
        <h2>Edit User Role</h2>
        <div id="roleOptions"></div>
        <button onclick="saveRoles()">Save</button>
        <button onclick="closeModal()">Close</button>
    </div>
</div>

<script>
    let selectedUserId;

    function fetchUsers() {
        const role = document.getElementById("role").value;
        const name = document.getElementById("name").value;
        const email = document.getElementById("email").value;

        fetch("/admin/users?role="+role+"&name="+name+"&email="+email)
            .then(response => response.text())
            .then(html => {
                document.getElementById("userTable").innerHTML = html;
            })
            .catch(error => console.error('Error fetching users:', error));
    }

    function editUserRole(userId) {
        selectedUserId = userId;
        fetch("/admin/userRoles?userId="+userId)
            .then(response => response.json())
            .then(data => {
            	console.log(data);
                document.getElementById("roleOptions").innerHTML = data.roles.map(role => "<label><input type='checkbox' "+(role.assigned ? 'checked' : '') +" data-role-id="+role.roleId+"> "+role.roleName+"</label>").join('');
                document.getElementById("editRoleModal").style.display = "block";
            });
    }

    function saveRoles() {
        const roleIds = Array.from(document.querySelectorAll('#roleOptions input:checked')).map(input => input.dataset.roleId);
		console.log(roleIds);
        fetch("/admin/updateUserRoles", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ userId: selectedUserId, roleIds })
        })
        .then(response => response.json())
        .then(() => closeModal())
        .catch(error => console.error('Error updating roles:', error));
    }

    function closeModal() {
        document.getElementById("editRoleModal").style.display = "none";
        location.reload();
    }
</script>

</body>
</html>

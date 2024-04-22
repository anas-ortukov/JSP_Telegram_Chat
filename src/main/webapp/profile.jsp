<%@ page import="uz.oasis.demo.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: anas
  Date: 22/04/24
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-light">
<%
    User currentUser = (User) request.getSession().getAttribute("currentUser");
    Object image = request.getSession().getAttribute("profileImage");
%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">
                    <form action="/profile" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-3">
                            <label for="photo">
                                <input type="file" name="profileImage" id="photo" class="d-none">
                                <% if (image != null) { %>
                                <img src="/file?part=true" alt="User Avatar" class="rounded-circle"
                                     width="100" height="100">
                                <% } else { %>
                                <img src="/file?id=<%=currentUser.getId()%>" alt="User Avatar" class="rounded-circle"
                                     width="100" height="100"
                                     onerror="this.src='https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg'">
                                <% } %>
                            </label>
                        </div>
                        <div class="row justify-content-center">
                            <button type="submit" class="btn btn-outline-primary" style="width: 150px">Upload</button>
                        </div>
                    </form>
                    <form method="get" action="/profile">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input name="name" type="text" class="form-control" id="name"
                                   value="<%=currentUser.getName()%>">
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <a href="/" class="btn btn-secondary">Back</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

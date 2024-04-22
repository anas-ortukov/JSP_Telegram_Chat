<%@ page import="java.util.List" %>
<%@ page import="uz.oasis.demo.repo.UserRepo" %>
<%@ page import="uz.oasis.demo.entity.User" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Objects" %>
<%@ page import="uz.oasis.demo.repo.MessageRepo" %>
<%@ page import="uz.oasis.demo.entity.Message" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar-rounded {
            border-radius: 20px;
        }
    </style>
</head>
<body>

<%
    UserRepo userRepo = new UserRepo();
    List<User> users = userRepo.findAll();
    User sender = (User) request.getSession().getAttribute("currentUser");
    MessageRepo messageRepo = new MessageRepo();
    UUID receiver = null;
    if (request.getSession().getAttribute("receiverId") != null) {
        receiver = UUID.fromString(request.getSession().getAttribute("receiverId").toString());
    }
%>

<div class="row">
    <div class="col-10 offset-1 mt-4">
        <nav class="navbar navbar-expand-lg navbar-light bg-primary navbar-rounded shadow">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="/file?id=<%=sender.getId()%>" alt=".." width="30" height="30"
                                     class="rounded-circle me-2"
                                     onerror="this.src='https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg'">
                                <%= sender.getName()%>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/profile.jsp">Profile Settings</a></li>
                                <li><a class="dropdown-item" href="/auth">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class="col-3 overflow-auto" style="max-height: 750px;">
                <% for (User user : users) {
                    if (!user.getId().equals(sender.getId())) { %>
                <div class="card my-4 ">
                    <a class="card-body <%=Objects.equals(user.getId(), receiver) ? "bg-primary text-white":""%>"
                       href="/chat?id=<%=user.getId()%>" style="text-decoration: none">
                        <img src="/file?id=<%=user.getId()%>" class="rounded-circle" width="40"
                             height="40"
                             onerror="this.src='https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg'">
                        <%=user.getName()%>
                    </a>
                </div>
                <% }
                } %>
            </div>
            <div class="col-8 offset-1 my-4">
                <div class="container">
                    <div id="messageContainer" class="overflow-auto" style="max-height: 650px;">
                        <% List<Message> messages = messageRepo.getConversation(sender, receiver);
                            LocalDate currentDate = null;
                            for (Message message : messages) {
                                LocalDate messageDate = message.getCreatedAt().toLocalDate();
                                if (currentDate == null || !currentDate.equals(messageDate)) { %>
                        <div class="row justify-content-center mt-4">
                            <div class="col-3">
                                <div class="card">
                                    <div class="card-body text-center">
                                        <p class="card-text"><%= messageDate.format(DateTimeFormatter.ofPattern("d MMMM")) %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }
                            currentDate = messageDate; // Update the current date
                            if (message.getSender().getId().equals(sender.getId())) { %>
                        <div class="row justify-content-end mt-3">
                            <div class="col-6">
                                <div class="card bg-secondary text-white">
                                    <div class="card-body">
                                        <p class="card-text"><%= message.getText() %></p>
                                        <small><%= message.showTime() %></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="row justify-content-start mt-3">
                            <div class="col-6">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <p class="card-text"><%= message.getText() %></p>
                                        <small class="text-muted"><%= message.showTime() %></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }
                        } %>
                    </div>
                </div>
                <% if (receiver != null) { %>
                <div class="container offset-4 col-8 mt-4">
                    <div class="row mt-3">
                        <div class="col">
                            <form action="/chat" method="post">
                                <div class="input-group mb-3">
                                    <textarea name="message" class="form-control" rows="1"
                                              placeholder="Type your message..."></textarea>
                                    <button class="btn btn-outline-primary"  type="submit"><svg font-size="30px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                                        <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
                                    </svg></button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <% } %>


            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    window.onload = function() {
        var messageContainer = document.getElementById('messageContainer');
        messageContainer.scrollTop = messageContainer.scrollHeight;
    };
</script>

</body>
</html>
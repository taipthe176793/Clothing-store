<%-- 
    Document   : chatting-screen
    Created on : Jul 17, 2024, 1:25:50 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chat</title>
        <script src="https://js.pusher.com/8.2.0/pusher.min.js"></script>
        <script>
            Pusher.logToConsole = true;

            var pusher = new Pusher('72b2a0d0d5af33522f53', {
                cluster: 'ap1'
            });

            var channel = pusher.subscribe('chat-channel');
            channel.bind('message-event', function (data) {
                var chatArea = document.getElementById("chatArea");
                chatArea.value += data.message + "\n";
                alert(JSON.stringify(data));
            });
        </script>
    </head>
    <body>
        <h1>Chat</h1>
        <textarea id="chatArea" rows="20" cols="50" readonly></textarea><br/>
        <input name="message" type="text" id="messageInput" />
        <button onclick="sendMessage()">Send</button>



        <script src="https://www.gstatic.com/firebasejs/9.6.10/firebase-app.js"></script>
        <script src="https://www.gstatic.com/firebasejs/9.6.10/firebase-database.js"></script>
        <script src="https://js.pusher.com/7.0/pusher.min.js"></script>

        <script>
            // Your web app's Firebase configuration
            var firebaseConfig = {
                apiKey: "YOUR_API_KEY",
                authDomain: "chatting-160c6.firebaseapp.com",
                databaseURL: "https://chatting-160c6-default-rtdb.asia-southeast1.firebasedatabase.app",
                projectId: "chatting-160c6",
                storageBucket: "chatting-160c6.appspot.com",
                messagingSenderId: "660335277918",
                appId: "1:660335277918:web:6f07e9cb4e722a656101cf",
                measurementId: "G-CXHS8DQX73"
            };

            // Initialize Firebase
            firebase.initializeApp(firebaseConfig);
            var database = firebase.database();
            firebase.analytics();
            const autth = firebase.auth();
            const db = firebase.firestore();

            function sendMessage() {
                var message = document.getElementById("messageInput").value;
                database.ref("messages").push().set({
                    "message": message
                });
                document.getElementById("messageInput").value = "";
            }

            database.ref("messages").on("child_added", function (snapshot) {
                var chatArea = document.getElementById("chatArea");
                chatArea.value += snapshot.val().message + "\n";
            });

        </script>

        <script>
            function sendMessage() {
                var message = document.getElementById("messageInput").value;
                fetch('../sendMessage', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({message: message})
                });
                document.getElementById("messageInput").value = "";
            }
        </script>
    </body>
</html>

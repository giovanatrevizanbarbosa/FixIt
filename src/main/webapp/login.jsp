<%@ page import="java.util.UUID" %><%--
  Created by IntelliJ IDEA.
  User: gitre
  Date: 16/10/2024
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<html class="h-full" data-theme="garden">
<head>
    <title>FixIt - Entrar</title>
    <link
            href="https://cdn.jsdelivr.net/npm/daisyui@4.12.13/dist/full.min.css"
            rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/x-icon" href="images/fixit.png">
</head>
<%
    String formToken = UUID.randomUUID().toString();
    session.setAttribute("formToken", formToken);
%>
<body class="h-full bg-base-300">
<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-sm">
        <img class="mx-auto size-32 w-auto" src="images/fixit.png"
             alt="FixIt">
    </div>
    <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
        <form class="space-y-6" action="entrar" method="POST">
            <input type="hidden" name="formToken" value="<%= formToken %>">
            <div>
                <label for="email" class="block text-sm font-medium leading-6 text-gray-900">E-mail</label>
                <div class="mt-2">
                    <input id="email" name="email" type="email" autocomplete="email" required class="input input-bordered block w-full text-gray-900 placeholder:text-gray-400 sm:text-sm sm:leading-6">
                </div>
            </div>
            <div>
                <div class="flex items-center justify-between">
                    <label for="password" class="block text-sm font-medium leading-6 text-gray-900">Senha</label>
                </div>
                <div class="mt-2">
                    <input id="password" name="password" type="password" autocomplete="current-password" required class="input input-bordered block w-full text-gray-900 placeholder:text-gray-400 sm:text-sm sm:leading-6">
                </div>
            </div>
            <div>
                <button type="submit" class="flex w-full justify-center btn btn-neutral w-full">Entrar</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.tailwindcss.com"></script>
</body>
</html>

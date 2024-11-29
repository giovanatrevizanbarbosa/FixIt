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
<html class="h-full" data-theme="corporate">
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
<body class="h-full">
    <c:if test="${result == 'error'}">
        <div role="alert" class="alert alert-error fixed w-fit top-2 right-4 z-[99]">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="m9.75 9.75 4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <span>Erro ao fazer login. Revise seus dados ou contate com seu administrador.</span>
            <div>
                <button class="btn btn-sm btn-ghost close-alert">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
    </c:if>
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
                <div class="mt-2">
                    <label for="password" class="input input-bordered flex items-center gap-2 text-sm font-medium leading-6 text-gray-600">
                        <input id="password" name="password" type="password" autocomplete="current-password" required placeholder="Senha"
                               class="grow text-gray-900 placeholder:text-gray-400 sm:text-sm sm:leading-6">
                        <label class="btn btn-ghost btn-sm btn-circle swap swap-rotate">
                            <input id="showPassword" type="checkbox">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                                 class="size-6 swap-off"
                                 id="hidden-password">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                            </svg>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                                 class="size-6 swap-on"
                                 id="visible-password">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                              <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                            </svg>
                        </label>
                    </label>
                </div>
            </div>
            <div>
                <button type="submit" class="flex w-full justify-center btn btn-neutral w-full">Entrar</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.tailwindcss.com"></script>
<script defer src="scripts/utils.js"></script>
<script defer src="scripts/login.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html class="h-full" data-theme="cmyk">
<head>
<meta charset="UTF-8">
<title>FixIt</title>
<link
	href="https://cdn.jsdelivr.net/npm/daisyui@4.12.13/dist/full.min.css"
	rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/computer.png">
</head>
<body class="h-full">
	<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
		<c:if test="${result == 'registered'}">
			<div role="alert" class="alert alert-success fixed w-fit top-0 right-4">
				<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-6 w-6 shrink-0 stroke-current"
						fill="none"
						viewBox="0 0 24 24">
					<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
				</svg>
				<span>Cadastro concluído com sucesso.</span>
			</div>
		</c:if>
		<c:if test="${result == 'notRegistered'}">
			<div role="alert" class="alert alert-error fixed w-fit top-0 right-4">
				<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-6 w-6 shrink-0 stroke-current"
						fill="none"
						viewBox="0 0 24 24">
					<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
				</svg>
				<span>Cadastro não pode ser concluído.</span>
			</div>
		</c:if>
		<div class="sm:mx-auto sm:w-full sm:max-w-sm">
			<img class="mx-auto size-16 w-auto" src="images/computer.png"
				alt="FixIt">
			<h2
				class="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">Crie
				sua conta</h2>
		</div>
		<div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
			<form class="space-y-6"	 method="POST" action="client-register">
				<label class="input input-bordered flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
					  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
					</svg>
				  <input type="text" class="grow" name="name" placeholder="Nome" required/>
				</label>
				<label class="input input-bordered flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
					  <path stroke-linecap="round" stroke-linejoin="round" d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Zm6-10.125a1.875 1.875 0 1 1-3.75 0 1.875 1.875 0 0 1 3.75 0Zm1.294 6.336a6.721 6.721 0 0 1-3.17.789 6.721 6.721 0 0 1-3.168-.789 3.376 3.376 0 0 1 6.338 0Z" />
					</svg>
				  <input type="text" class="grow" name="cpf" placeholder="CPF" required minlength="11" maxlength="11"/>
				</label>					
				<label class="input input-bordered flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
					  <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75" />
					</svg>
				  <input type="email" class="grow" name="email" placeholder="E-mail" required/>
				</label>
				<label class="input input-bordered flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
					  <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 0 0 6 3.75v16.5a2.25 2.25 0 0 0 2.25 2.25h7.5A2.25 2.25 0 0 0 18 20.25V3.75a2.25 2.25 0 0 0-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3" />
					</svg>
				  <input type="text" class="grow" name="phone" placeholder="Telefone/Celular" required maxlength="20"/>
				</label>								
				
				<label class="input input-bordered flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
					  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 0 1 3 3m3 0a6 6 0 0 1-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1 1 21.75 8.25Z" />
					</svg>

				  <input type="password" class="grow" name="password" placeholder="Senha" required minlength="6"/>
				</label>
				<button type="submit" class="btn btn-primary w-full">Criar conta</button>
			</form>
		</div>
	</div>
	<script src="https://cdn.tailwindcss.com"></script>
</body>
</html>
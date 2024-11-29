<%@ page import="java.util.UUID" %>
<%@ page import="model.State" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html class="h-full" data-theme="corporate">
<head>
<meta charset="UTF-8">
<title>FixIt</title>
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
<jsp:include page="components/navbar.jsp"></jsp:include>
	<c:if test="${result == 'notRegistered'}">
		<div role="alert" class="alert alert-error fixed w-fit top-2 right-4 z-[99]">
			<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
				<path stroke-linecap="round" stroke-linejoin="round" d="m9.75 9.75 4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
			</svg>
			<span>Cadastro não pode ser concluído.</span>
			<div>
				<button class="btn btn-sm btn-ghost close-alert">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
						<path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
					</svg>
				</button>
			</div>
		</div>
	</c:if>
	<div class="min-h-full flex-col justify-center p-6 lg:px-8 h-screen">
		<div class="mt-10 sm:mx-auto sm:w-full sm:max-w-lg">
			<form class="space-y-6"	 method="POST" action="novo-cliente">
				<input type="hidden" name="formToken" value="<%= formToken %>">
				<h2 class="my-10 text-start text-2xl block font-medium leading-6 tracking-tight">Dados Pessoais</h2>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Nome</label>
						<div class="mt-2">
							<input id="name" name="name" type="text" autocomplete="name" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="cpf" class="block text-sm font-medium leading-6">CPF</label>
						<div class="mt-2">
							<input id="cpf" name="cpf" type="text" autocomplete="cpf" required pattern="^[^\s]*$" maxlength="14" minlength="14"
								   class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="phone" class="block text-sm font-medium leading-6">Celular</label>
						<div class="mt-2">
							<input id="phone" name="phone" type="tel" autocomplete="phone" required placeholder="(xx) xxxxx-xxxx" minlength="15" maxlength="15"
								   class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="email" class="block text-sm font-medium leading-6">E-mail</label>
						<div class="mt-2">
							<input id="email" name="email" type="email" autocomplete="email" required
								   class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="password" class="block text-sm font-medium leading-6">Senha</label>
						<div class="mt-2">
							<input id="password" name="password" type="password" autocomplete="password"
								   required minlength="6"
								   class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
				</div>
				<h2 class="my-10 text-start text-2xl block font-medium leading-6 tracking-tight">Endereço</h2>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Rua</label>
						<div class="mt-2">
							<input id="street" name="street" type="text" autocomplete="street" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Número</label>
						<div class="mt-2">
							<input id="number" name="number" type="number" step="1" autocomplete="number"
								   required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6"
								   pattern="\d*" maxlength="10"
							>
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">CEP</label>
						<div class="mt-2">
							<input id="cep" name="cep" type="text" autocomplete="cep"
								   required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6"
								   maxlength="9"
							>
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Complemento</label>
						<div class="mt-2">
							<input id="complement" name="complement" type="text" autocomplete="complement" class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Bairro</label>
						<div class="mt-2">
							<input id="neighborhood" name="neighborhood" type="text" autocomplete="neighborhood" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="name" class="block text-sm font-medium leading-6">Cidade</label>
						<div class="mt-2">
							<input id="city" name="city" type="text" autocomplete="city" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="state" class="block text-sm font-medium leading-6">Estado</label>
						<select name="state" class="select select-bordered mt-2" id="state">
							<c:forEach var="state" items="${states}">
								<option value="${state}">${state.getDescription()}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<button type="submit" class="btn btn-accent text-base-100 w-full">Adicionar</button>
				<a href="inicio" class="btn btn-ghost w-full">Cancelar</a>
			</form>
		</div>
	</div>
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="scripts/utils.js"></script>
	<script src="scripts/customer-register.js"></script>
</body>
</html>
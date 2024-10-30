<%@ page import="java.util.UUID" %>
<%@ page import="model.State" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html class="h-full" data-theme="garden">
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
			<form class="space-y-6"	 method="POST" action="nova-ordem-de-servico">
				<input type="hidden" name="formToken" value="<%= formToken %>">
				<h2 class="my-10 text-start text-2xl block font-medium leading-6 tracking-tight"></h2>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="description" class="block text-sm font-medium leading-6">Descrição</label>
						<div class="mt-2">
							<textarea class="textarea textarea-bordered textarea-md w-full" id="description" name="description"></textarea>
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="observation" class="block text-sm font-medium leading-6">Observação</label>
						<div class="mt-2">
							<textarea class="textarea textarea-bordered textarea-md w-full" id="observation" name="observation"></textarea>
						</div>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="emissionDate" class="block text-sm font-medium leading-6">Data de Emissão</label>
						<div class="mt-2">
							<input id="emissionDate" name="emissionDate" type="date" autocomplete="emissionDate" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="price" class="block text-sm font-medium leading-6">Valor</label>
						<div class="mt-2">
							<input id="price" name="price" type="number" step="0.1" autocomplete="price" required class="input input-bordered block w-full placeholder:text-gray-400 sm:text-sm sm:leading-6">
						</div>
					</div>
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="paymentMethod" class="block text-sm font-medium leading-6">Método de Pagamento</label>
						<select name="paymentMethod" class="select select-bordered mt-2 sm:mx-auto sm:w-full sm:max-w-lg" id="paymentMethod">
							<c:forEach var="paymentMethod" items="${paymentMethods}">
								<option value="${paymentMethod.getId()}">${paymentMethod.getName()}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="flex flex-row justify-center gap-4 sm:mx-auto sm:w-full sm:max-w-lg">
					<div class="sm:mx-auto sm:w-full sm:max-w-lg">
						<label for="customer" class="block text-sm font-medium leading-6">Cliente</label>
						<select name="customer" class="select select-bordered mt-2 sm:mx-auto sm:w-full sm:max-w-lg" id="customer">
							<c:forEach var="customer" items="${customers}">
								<option value="${customer.getId()}">${customer.getName()}</option>
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
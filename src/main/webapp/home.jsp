<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html data-theme="corporate" class="h-full">
<head>
<meta charset="UTF-8">
<title>FixIt - Início</title>
<link rel="icon" type="image/x-icon" href="images/fixit.png">
<link
        href="https://cdn.jsdelivr.net/npm/daisyui@4.12.13/dist/full.min.css"
        rel="stylesheet" type="text/css" />
</head>
<body class="h-full">
<jsp:include page="components/navbar.jsp"></jsp:include>
<c:if test="${result == 'registered'}">
    <div role="alert" class="alert alert-success fixed w-fit top-2 right-4 z-[99]">
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
        <div>
            <button class="btn btn-sm btn-ghost close-alert">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
    </div>
</c:if>
<div class="flex w-full flex-col justify-center px-6 py-12 lg:px-8 space-y-2">
    <div class="collapse collapse-plus border-base-300 border">
        <input type="checkbox" name="collapse-ordens" checked="checked" />
        <div class="collapse-title text-xl font-medium">Ordens de Serviço</div>
        <div class="collapse-content">
            <div class="overflow-x-auto">
                <table class="table table-zebra">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Descrição</th>
                        <th>Data de Emissão</th>
                        <th>Data de Conclusão</th>
                        <th>Preço</th>
                        <th>Observação</th>
                        <th>Método de Pagamento</th>
                        <th>Status</th>
                        <th>Cliente</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="serviceOrder" items="${serviceOrders}" varStatus="index">
                        <tr>
                            <th>${index.count}</th>
                            <td>${serviceOrder.getDescription()}</td>
                            <td>${serviceOrder.getEmissionDate()}</td>
                            <c:choose>
                                <c:when test="${serviceOrder.getCompletionDate() == null}">
                                    <td class="text-center">N/A</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${serviceOrder.getCompletionDate()}</td>
                                </c:otherwise>
                            </c:choose>
                            <td>${serviceOrder.getPrice()}</td>
                            <td>${serviceOrder.getObservation()}</td>
                            <td>${serviceOrder.getPaymentMethod().getName()}</td>
                            <td>${serviceOrder.getStatus().getDescription()}</td>
                            <td>${serviceOrder.getCustomer().getName()}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="collapse collapse-plus border-base-300 border">
        <input type="checkbox" name="collapse-clientes" checked="checked"/>
        <div class="collapse-title text-xl font-medium">Clientes</div>
        <div class="collapse-content">
            <div class="overflow-x-auto">
                <table class="table table-zebra">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="customer" items="${customers}" varStatus="index">
                        <tr>
                            <th>${index.count}</th>
                            <td>${customer.getName()}</td>
                            <td>${customer.getEmail()}</td>
                            <c:choose>
                                <c:when test="${customer.getActive()}">
                                    <td>
                                        <span class="tooltip tooltip-success" data-tip="Ativo">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-success">
                                                <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm13.36-1.814a.75.75 0 1 0-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 0 0-1.06 1.06l2.25 2.25a.75.75 0 0 0 1.14-.094l3.75-5.25Z" clip-rule="evenodd" />
                                            </svg>
                                        </span>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <span class="tooltip" data-tip="Inativo">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-base-300">
                                                <path fill-rule="evenodd" d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25Zm3 10.5a.75.75 0 0 0 0-1.5H9a.75.75 0 0 0 0 1.5h6Z" clip-rule="evenodd" />
                                            </svg>
                                        </span>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="collapse collapse-plus border-base-300 border">
        <input type="checkbox" name="collapse-clientes" checked="checked"/>
        <div class="collapse-title text-xl font-medium">Funcionários</div>
        <div class="collapse-content">
            <div class="overflow-x-auto">
                <table class="table table-zebra">
                    <thead>
                    <tr>
                        <th></th>
                        <th>E-mail</th>
                        <th>Status</th>
                        <c:if test="${user.getAdmin()}">
                            <th>Nível de Acesso</th
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="userI" items="${users}" varStatus="index">
                        <tr>
                            <th>${index.count}</th>
                            <td>${userI.getEmail()}</td>
                            <c:choose>
                                <c:when test="${userI.getActive()}">
                                    <td>
                                        <span class="tooltip tooltip-success" data-tip="Ativo">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-success">
                                                <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm13.36-1.814a.75.75 0 1 0-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 0 0-1.06 1.06l2.25 2.25a.75.75 0 0 0 1.14-.094l3.75-5.25Z" clip-rule="evenodd" />
                                            </svg>
                                        </span>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <span class="tooltip" data-tip="Inativo">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-base-300">
                                                <path fill-rule="evenodd" d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25Zm3 10.5a.75.75 0 0 0 0-1.5H9a.75.75 0 0 0 0 1.5h6Z" clip-rule="evenodd" />
                                            </svg>
                                        </span>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${user.getAdmin()}">
                                <c:choose>
                                    <c:when test="${userI.getAdmin()}">
                                        <td>
                                            <span class="tooltip" data-tip="Administrador">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                                                  <path d="M18.75 12.75h1.5a.75.75 0 0 0 0-1.5h-1.5a.75.75 0 0 0 0 1.5ZM12 6a.75.75 0 0 1 .75-.75h7.5a.75.75 0 0 1 0 1.5h-7.5A.75.75 0 0 1 12 6ZM12 18a.75.75 0 0 1 .75-.75h7.5a.75.75 0 0 1 0 1.5h-7.5A.75.75 0 0 1 12 18ZM3.75 6.75h1.5a.75.75 0 1 0 0-1.5h-1.5a.75.75 0 0 0 0 1.5ZM5.25 18.75h-1.5a.75.75 0 0 1 0-1.5h1.5a.75.75 0 0 1 0 1.5ZM3 12a.75.75 0 0 1 .75-.75h7.5a.75.75 0 0 1 0 1.5h-7.5A.75.75 0 0 1 3 12ZM9 3.75a2.25 2.25 0 1 0 0 4.5 2.25 2.25 0 0 0 0-4.5ZM12.75 12a2.25 2.25 0 1 1 4.5 0 2.25 2.25 0 0 1-4.5 0ZM9 15.75a2.25 2.25 0 1 0 0 4.5 2.25 2.25 0 0 0 0-4.5Z" />
                                                </svg>
                                            </span>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            <span class="tooltip tooltip-secondary" data-tip="Comum">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                                                  <path fill-rule="evenodd" d="M7.5 6a4.5 4.5 0 1 1 9 0 4.5 4.5 0 0 1-9 0ZM3.751 20.105a8.25 8.25 0 0 1 16.498 0 .75.75 0 0 1-.437.695A18.683 18.683 0 0 1 12 22.5c-2.786 0-5.433-.608-7.812-1.7a.75.75 0 0 1-.437-.695Z" clip-rule="evenodd" />
                                                </svg>
                                            </span>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.tailwindcss.com"></script>
<script src="scripts/utils.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html data-theme="garden" class="h-full">
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
<div class="flex flex-col justify-center px-6 py-12 lg:px-8 space-y-2">
    <div class="join join-vertical w-full">
        <div class="collapse collapse-plus join-item bg-base-200">
            <input type="checkbox" name="collapse-ordens" checked="checked" />
            <div class="collapse-title text-xl font-medium">Ordens de Serviço</div>
            <div class="collapse-content">
                <div class="overflow-x-auto">
                    <table class="table">
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
                                <th class="border-t border-neutral-content">${index.count}</th>
                                <td class="border-t border-neutral-content">${serviceOrder.getDescription()}</td>
                                <td class="border-t border-neutral-content">${serviceOrder.getEmissionDate()}</td>
                                <c:choose>
                                    <c:when test="${serviceOrder.getCompletionDate() == null}">
                                        <td class="border-t border-neutral-content text-center">-</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="border-t border-neutral-content">${serviceOrder.getCompletionDate()}</td>
                                    </c:otherwise>
                                </c:choose>
                                <td class="border-t border-neutral-content">${serviceOrder.getPrice()}</td>
                                <td class="border-t border-neutral-content">${serviceOrder.getObservation()}</td>
                                <td class="border-t border-neutral-content">${serviceOrder.getPaymentMethod().getName()}</td>
                                <td class="border-t border-neutral-content">${serviceOrder.getStatus().getDescription()}</td>
                                <td class="border-t border-neutral-content">${serviceOrder.getCustomer().getName()}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="collapse collapse-plus join-item bg-base-200">
            <input type="checkbox" name="collapse-clientes" />
            <div class="collapse-title text-xl font-medium">Clientes</div>
            <div class="collapse-content">
                <div class="overflow-x-auto">
                    <table class="table">
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
                                <th class="border-t border-neutral-content">${index.count}</th>
                                <td class="border-t border-neutral-content">${customer.getName()}</td>
                                <td class="border-t border-neutral-content">${customer.getEmail()}</td>
                                <c:choose>
                                    <c:when test="${customer.getActive() == true}">
                                        <td class="border-t border-neutral-content">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-success">
                                                <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm13.36-1.814a.75.75 0 1 0-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 0 0-1.06 1.06l2.25 2.25a.75.75 0 0 0 1.14-.094l3.75-5.25Z" clip-rule="evenodd" />
                                            </svg>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="border-t border-neutral-content">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6 text-base-300">
                                                <path fill-rule="evenodd" d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25Zm3 10.5a.75.75 0 0 0 0-1.5H9a.75.75 0 0 0 0 1.5h6Z" clip-rule="evenodd" />
                                            </svg>
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
    </div>
</div>

<script src="https://cdn.tailwindcss.com"></script>
<script src="scripts/utils.js"></script>
</body>
</html>
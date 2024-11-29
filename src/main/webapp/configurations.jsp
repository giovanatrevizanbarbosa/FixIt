<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html data-theme="corporate" class="full">
<head>
<meta charset="UTF-8">
<title>FixIt</title>
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
<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8 space-y-2">
    <div class="collapse collapse-plus border-base-300 border">
        <input type="checkbox" name="collapse-metodos-pagamento" checked="checked" />
        <div class="collapse-title text-xl font-medium">Métodos de Pagamento</div>
        <div class="collapse-content">
            <div class="overflow-x-auto">
                <table class="table table-zebra">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Nome</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="paymentMethod" items="${paymentMethods}" varStatus="index">
                            <tr>
                                <th>${index.count}</th>
                                <td>${paymentMethod.getName()}</td>
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
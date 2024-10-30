<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="navbar bg-neutral text-neutral-content">
    <div class="navbar-start">
        <div class="dropdown bg-neutral text-neutral-content">
            <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
                <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                    <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M4 6h16M4 12h8m-8 6h16" />
                </svg>
            </div>
            <ul
                    tabindex="0"
                    class="menu menu-sm dropdown-content bg-base-content text-neutral-content rounded-box z-[1] mt-3 w-52 p-2 shadow">
                <li>
                    <a>Adicionar</a>
                    <ul class="p-2">
                        <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/novo-cliente">Novo Cliente</a></li>
                        <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/nova-ordem-de-servico">Nova Ordem de Serviço</a></li>
                        <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/novo-metodo-de-pagamento">Novo Método de Pagamento</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <a href="inicio" class="btn btn-ghost text-xl">FixIt</a>
    </div>
    <div class="navbar-center hidden lg:flex">
        <ul class="menu menu-horizontal px-1 z-[1] bg-neutral text-neutral-content">
            <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/novo-cliente">Novo Cliente</a></li>
            <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/nova-ordem-de-servico">Nova Ordem de Serviço</a></li>
            <li class="bt btn-ghost rounded-lg"><a href="${pageContext.request.contextPath}/novo-metodo-de-pagamento">Novo Método de Pagamento</a></li>
        </ul>
    </div>
    <div class="navbar-end gap-2">
        <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="avatar placeholder">
                <div class="w-8 rounded-full">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"></path>
                    </svg>
                </div>
            </div>
            <ul
                    tabindex="0"
                    class="menu menu-sm dropdown-content bg-base-content text-neutral-content rounded-box z-[1] mt-3 w-52 p-2 shadow">
                <li>
                    <a class="justify-between">
                        Perfil
                    </a>
                </li>
                <li><a href="configuracoes">Configurações</a></li>
                <li><a>Sair</a></li>
            </ul>
        </div>
    </div>
</div>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card shadow-sm border-0 p-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="card-title mb-0">Quản Lý Người Dùng & Phân Quyền</h4>
        <form class="d-flex" action="<c:url value='/admin/users' />" method="get">
            <input class="form-control me-2" type="search" name="keyword" value="${param.keyword}" placeholder="Tìm theo tên/email/sđt...">
            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
        </form>
    </div>

    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Họ tên</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.id}</td>
                    <td><strong><c:out value="${u.username}"/></strong></td>
                    <td><c:out value="${u.name}"/></td>
                    <td><c:out value="${u.phone}"/></td>
                    <td><c:out value="${u.email}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${u.active}"><span class="badge bg-success">Hoạt động</span></c:when>
                            <c:otherwise><span class="badge bg-danger">Bị khóa</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <form action="<c:url value='/admin/users/update' />" method="post" class="d-inline">
                            <input type="hidden" name="id" value="${u.id}">
                            <input type="hidden" name="name" value="${u.name}">
                            <input type="hidden" name="phone" value="${u.phone}">
                            <input type="hidden" name="email" value="${u.email}">
                            <input type="hidden" name="isActive" value="${u.active ? 'false' : 'true'}">
                            <button type="submit" class="btn ${u.active ? 'btn-outline-danger' : 'btn-outline-success'} btn-sm">
                                ${u.active ? 'Khóa TK' : 'Mở khóa'}
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

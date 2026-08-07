<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<section class="section">
    <div class="card shadow-sm border-0">
        <div class="card-header d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 bg-transparent border-bottom py-3">
            <h4 class="card-title mb-0 text-primary font-bold"><i class="bi bi-people-fill me-2"></i>Quản Lý Người Dùng & Phân Quyền</h4>
            <form action="<c:url value='/admin/users' />" method="get" style="max-width: 320px; width: 100%;">
                <div class="input-group">
                    <input class="form-control" type="search" name="keyword" value="${param.keyword}" placeholder="Tìm theo tên/email/sđt...">
                    <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                </div>
            </form>
        </div>
        <div class="card-body py-3">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Username</th>
                            <th>Họ tên</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="ps-3 font-semibold">${u.id}</td>
                                <td><span class="font-bold text-dark"><c:out value="${u.username}"/></span></td>
                                <td><c:out value="${u.name}"/></td>
                                <td><c:out value="${u.phone}"/></td>
                                <td><c:out value="${u.email}"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="badge bg-light-success text-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light-danger text-danger">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-3">
                                    <form action="<c:url value='/admin/users/update' />" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <input type="hidden" name="name" value="${u.name}">
                                        <input type="hidden" name="phone" value="${u.phone}">
                                        <input type="hidden" name="email" value="${u.email}">
                                        <input type="hidden" name="isActive" value="${u.active ? 'false' : 'true'}">
                                        <button type="submit" class="btn btn-sm ${u.active ? 'btn-light-danger text-danger' : 'btn-light-success text-success'} font-semibold">
                                            <i class="bi ${u.active ? 'bi-lock-fill' : 'bi-unlock-fill'} me-1"></i>
                                            ${u.active ? 'Khóa TK' : 'Mở khóa'}
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

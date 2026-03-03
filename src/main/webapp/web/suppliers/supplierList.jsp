<%@page import="java.util.List"%>
<%@page import="model.Suppliers"%>

<%
List<Suppliers> list =
(List<Suppliers>) request.getAttribute("listSuppliers");
%>

<h2>Supplier List</h2>

<a href="suppliers?action=create">
Create Supplier
</a>

<table border="1">

<tr>
<th>ID</th>
<th>Name</th>
<th>Type</th>
<th>Contact</th>
<th>Action</th>
</tr>

<% for(Suppliers s : list){ %>

<tr>

<td><%=s.getSupplierId()%></td>

<td><%=s.getName()%></td>

<td><%=s.getType()%></td>

<td><%=s.getContactInfo()%></td>

<td>

<a href="suppliers?action=edit&id=<%=s.getSupplierId()%>">
Edit
</a>

|

<a href="<%=request.getContextPath()%>/suppliers?action=delete&id=<%=s.getSupplierId()%>">
    Delete
</a>

</td>

</tr>

<% } %>

</table>
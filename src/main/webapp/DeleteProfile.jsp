<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
    <link rel="stylesheet" href="table.css">
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
</head>
<body>

<script id="replace_with_navbar" src="nav.js"></script>
    
<div class="table-wrapper">
    <h2 style="text-align: center; margin-bottom: 20px;">Delete Student</h2>
    
    <!-- Search Bar -->
    <div class="search-bar" style="text-align: center; margin-bottom: 20px;">
        <form method="post" action="DeleteStudentServlet">
            <input type="text" name="searchQuery" placeholder="Search by Student ID or Name" 
                   style="padding: 10px; width: 70%; border-radius: 20px; 
                          box-shadow: inset 3px 3px 5px #cbced1, inset -3px -3px 5px #fff; 
                          border: none; outline: none;">
            <button type="submit" style="padding: 10px 20px; margin-left: 10px; 
                                         background-color: #03A9F4; color: white; border: none; 
                                         border-radius: 20px; box-shadow: 3px 3px 3px #b1b1b1, 
                                         -3px -3px 3px #fff;">Search</button>
        </form>
    </div>

  <!-- Table with Dummy Data -->
<div class="table-wrapper">
    <table id="students-table">
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>101</td>
                <td>John Doe</td>
                <td><button onclick="deleteStudent(101)">Delete</button></td>
            </tr>
            <tr>
                <td>102</td>
                <td>Jane Smith</td>
                <td><button onclick="deleteStudent(102)">Delete</button></td>
            </tr>
            <tr>
                <td>103</td>
                <td>Mike Johnson</td>
                <td><button onclick="deleteStudent(103)">Delete</button></td>
            </tr>
            <tr>
                <td>104</td>
                <td>Emily Davis</td>
                <td><button onclick="deleteStudent(104)">Delete</button></td>
            </tr>
            <tr>
                <td>105</td>
                <td>David Wilson</td>
                <td><button onclick="deleteStudent(105)">Delete</button></td>
            </tr>
        </tbody>
    </table>
</div>

<script>
    // Dummy delete function to simulate student deletion
    function deleteStudent(studentId) {
        alert("Student with ID " + studentId + " has been deleted.");
        // Normally, here you would make a request to the server to delete the student
    }

    // Function to filter students based on the search input
    function filterStudents() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("search");
        filter = input.value.toUpperCase();
        table = document.getElementById("students-table");
        tr = table.getElementsByTagName("tr");

        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0]; // Check the first column (Student ID)
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

</body>
</html>
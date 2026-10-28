
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="Practical9.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Placement Dashboard</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f6fa;
            margin: 0;
            padding: 25px;
            color: #243447;
        }

        .container {
            max-width: 1150px;
            margin: auto;
        }

        h1 {
            color: #17365D;
            margin-bottom: 25px;
        }

        h2 {
            color: #17365D;
            margin-top: 25px;
        }

        /* Placement Summary */
        .summary-table {
            width: 600px;
            max-width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 15px;
            box-shadow: 0 2px 6px #ddd;
        }

        .summary-table th,
        .summary-table td {
            border: 1px solid #d5dce5;
            padding: 13px 16px;
        }

        .summary-table th {
            background-color: #17365D;
            color: white;
            text-align: left;
        }

        .summary-table td:first-child {
            text-align: left;
            font-weight: bold;
        }

        .summary-table td.number {
            text-align: right;
            font-weight: bold;
            width: 180px;
        }

        .summary-table tr:nth-child(even) {
            background-color: #f2f5f9;
        }

        /* Student records */
        .records-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 15px;
        }

        .records-table th,
        .records-table td {
            border: 1px solid #d5dce5;
            padding: 11px;
        }

        .records-table th {
            background-color: #17365D;
            color: white;
            text-align: left;
        }

        .records-table tr:nth-child(even) {
            background-color: #f2f5f9;
        }

        .link {
            display: inline-block;
            margin-top: 22px;
            padding: 11px 18px;
            background-color: #17365D;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .link:hover {
            background-color: #24558a;
        }

        .message {
            color: #b42318;
            margin-top: 12px;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <h1>Placement Dashboard</h1>

            <!-- PLACEMENT SUMMARY -->
            <h2>Placement Summary</h2>

            <table class="summary-table">
                <tr>
                    <th>Placement Summary</th>
                    <th>Value</th>
                </tr>

                <tr>
                    <td>Total Students</td>
                    <td class="number">
                        <asp:Label ID="lblTotalStudents"
                            runat="server" Text="0">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>Placed Students</td>
                    <td class="number">
                        <asp:Label ID="lblPlacedStudents"
                            runat="server" Text="0">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>Unplaced Students</td>
                    <td class="number">
                        <asp:Label ID="lblUnplacedStudents"
                            runat="server" Text="0">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>Placement Percentage</td>
                    <td class="number">
                        <asp:Label ID="lblPlacementPercentage"
                            runat="server" Text="0.00%">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>Highest Package (LPA)</td>
                    <td class="number">
                        <asp:Label ID="lblHighestPackage"
                            runat="server" Text="0.00">
                        </asp:Label>
                    </td>
                </tr>
            </table>

            <!-- STUDENT PLACEMENT RECORDS -->
            <h2>Student Placement Records</h2>

            <asp:GridView ID="gvStudents"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="records-table"
                GridLines="Both"
                EmptyDataText="No student records found."
                CellPadding="8">

                <Columns>

                    <asp:BoundField
                        DataField="StudentId"
                        HeaderText="Student ID" />

                    <asp:BoundField
                        DataField="EnrollmentNo"
                        HeaderText="Enrollment No" />

                    <asp:BoundField
                        DataField="StudentName"
                        HeaderText="Student Name" />

                    <asp:BoundField
                        DataField="Department"
                        HeaderText="Department" />

                    <asp:BoundField
                        DataField="PassingYear"
                        HeaderText="Passing Year" />

                    <asp:TemplateField HeaderText="Is Placed">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(
                                Eval("IsPlaced"))
                                ? "Placed"
                                : "Not Placed" %>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

            <!-- COMPANY SUMMARY LINK -->
            <asp:HyperLink
                ID="lnkCompanies"
                runat="server"
                NavigateUrl="~/Companies.aspx"
                CssClass="link"
                Text="View Company Summary" />

            <br />

            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>

    </form>
</body>
</html>

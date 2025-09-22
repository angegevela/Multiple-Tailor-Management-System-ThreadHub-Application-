import 'package:flutter/material.dart';
import 'package:threadhub_system/Admin/pages/sidebar/menu.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  String filterBy = "All";
  final List<String> filters = ["Customer", "Tailor", "Administrator"];

  String? selectedUserName;
  bool showDetails = false;

  final List<Map<String, String>> users = [
    {
      "name": "Gali Alcantara",
      "type": "Customer",
      "function": "View Orders",
      "lastUsed": "2025-09-13 14:30",
    },
    {
      "name": "Kuzmic",
      "type": "Tailor",
      "function": "Update Profile",
      "lastUsed": "2025-09-12 09:15",
    },
    {
      "name": "Developer Zalid",
      "type": "Customer",
      "function": "Export Data",
      "lastUsed": "2025-09-11 18:40",
    },
    {
      "name": "Alice Doe",
      "type": "Customer",
      "function": "Browse Catalog",
      "lastUsed": "2025-09-10 11:20",
    },
    {
      "name": "Alilie Garcia",
      "type": "Customer",
      "function": "Request More Tailor",
      "lastUsed": "2025-09-09 12:00",
    },
    {
      "name": "Kyro Permaran",
      "type": "Customer",
      "function": "Place Order",
      "lastUsed": "2025-09-08 16:45",
    },
    {
      "name": "Giana Gabrielo",
      "type": "Customer",
      "function": "View Orders",
      "lastUsed": "2025-09-07 13:25",
    },
    {
      "name": "Paul Reese",
      "type": "Tailor",
      "function": "Accept Job",
      "lastUsed": "2025-09-06 08:30",
    },
    {
      "name": "Tesa Paez",
      "type": "Tailor",
      "function": "Update Measurements",
      "lastUsed": "2025-09-05 15:10",
    },
    {
      "name": "Alex De Guzman",
      "type": "Tailor",
      "function": "Upload Design",
      "lastUsed": "2025-09-04 17:50",
    },
    {
      "name": "Alen Santos",
      "type": "Tailor",
      "function": "Update Availability",
      "lastUsed": "2025-09-03 10:05",
    },
    {
      "name": "Al Baguinda",
      "type": "Tailor",
      "function": "Respond to Request",
      "lastUsed": "2025-09-02 09:55",
    },
    {
      "name": "Ferdinand Adlawan",
      "type": "Tailor",
      "function": "Edit Portfolio",
      "lastUsed": "2025-09-01 19:40",
    },
    {
      "name": "Jacinto Mendoza",
      "type": "Customer",
      "function": "Browse Catalog",
      "lastUsed": "2025-08-31 14:10",
    },
    {
      "name": "Denniz Mendoza",
      "type": "Customer",
      "function": "Place Order",
      "lastUsed": "2025-08-30 12:20",
    },
    {
      "name": "Jacinto Ash Ketchum",
      "type": "Customer",
      "function": "Export Data",
      "lastUsed": "2025-08-29 20:00",
    },
    {
      "name": "Angi Gabelo",
      "type": "Administrator",
      "function": "Manage Users",
      "lastUsed": "2025-09-14 09:00",
    },
    {
      "name": "Lukas Jabier",
      "type": "Administrator",
      "function": "System Audit",
      "lastUsed": "2025-08-28 08:45",
    },
  ];

  List<Map<String, String>> getFilteredUsers() {
    final q = searchQuery.trim().toLowerCase();
    return users.where((user) {
      final matchesFilter = filterBy == "All" || user['type'] == filterBy;
      final matchesSearch =
          q.isEmpty ||
          user['name']!.toLowerCase().contains(q) ||
          user['type']!.toLowerCase().contains(q);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _deleteSelected() {
    if (selectedUserName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user selected to delete')),
      );
      return;
    }
    setState(() {
      users.removeWhere((u) => u['name'] == selectedUserName);
      selectedUserName = null;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = getFilteredUsers();

    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF6082B6)),
      drawer: const Menu(),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Users',
                    style: TextStyle(
                      fontFamily: 'HermeneusOne',
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 13),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(Icons.delete, size: 18),
                            label: const Text("Delete"),
                            onPressed: _deleteSelected,
                          ),

                          const SizedBox(width: 8),

                          //Filter dropdown
                          PopupMenuButton<String>(
                            offset: const Offset(0, 40),
                            color: Colors.transparent,
                            elevation: 0,
                            onSelected: (value) {
                              setState(() {
                                filterBy = value;
                              });
                            },
                            itemBuilder: (context) {
                              final options = filterBy == "All"
                                  ? filters
                                  : ["All", ...filters];
                              return options.map((filter) {
                                final isSelected = filterBy == filter;
                                return PopupMenuItem<String>(
                                  value: filter,
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.blue[100]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                      border: const Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        filter,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            child: OutlinedButton.icon(
                              onPressed: null,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                              icon: const Icon(
                                Icons.filter_alt,
                                size: 18,
                                color: Colors.grey,
                              ),
                              label: Text(
                                filterBy == "All" ? "Filter by" : filterBy,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          //Search field
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _searchController,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.search, color: Colors.grey),
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 0),

                    //Users Summarize Table
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          if (!showDetails) ...[
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "User Type",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDetails = true;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.chevron_right,
                                      size: 25,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Function Used",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Last Used",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDetails = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 25,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Divider(height: 0),

                    // Table rows
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredUsers.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final name = user['name'] ?? "-";
                        final type = user['type'] ?? "-";
                        final functionUsed = user['function'] ?? "-";
                        final lastUsed = user['lastUsed'] ?? "-";
                        final isSelected = selectedUserName == name;

                        Color selectedTextbgColor;
                        if (isSelected && type == "Tailor") {
                          selectedTextbgColor = const Color(0xFF004D40);
                        } else if (isSelected && type == "Administrator") {
                          selectedTextbgColor = const Color(0xFF5682B1);
                        } else if (isSelected) {
                          selectedTextbgColor = Colors.grey.shade700;
                        } else {
                          selectedTextbgColor = index % 2 == 0
                              ? Colors.white
                              : Colors.grey[100]!;
                        }

                        final textStyle = TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                        );

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedUserName = selectedUserName == name
                                  ? null
                                  : name;
                            });
                          },
                          child: Container(
                            color: selectedTextbgColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                if (!showDetails) ...[
                                  Expanded(
                                    flex: 3,
                                    child: Text(name, style: textStyle),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(type, style: textStyle),
                                  ),
                                ] else ...[
                                  Expanded(
                                    flex: 3,
                                    child: Text(functionUsed, style: textStyle),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(lastUsed, style: textStyle),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    if (filteredUsers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          searchQuery.isEmpty
                              ? 'No users available'
                              : 'No results for "${searchQuery.trim()}"',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

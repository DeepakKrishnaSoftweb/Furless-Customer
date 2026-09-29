import 'package:flutter/material.dart';
import '../core/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.api});
  final Api api;

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  bool loading = true;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      data = await widget.api.bootstrap();
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void enquire() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => EnquirySheet(api: widget.api),
    );
  }

  Widget serviceCard(Map service) {
    return InkWell(
      onTap: enquire,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD9E8EB)),
        ),
        child: Row(children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF14B8AE), Color(0xFF4B7DFF)]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${service['name'] ?? 'Service'}', style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0A3147))),
            const SizedBox(height: 3),
            Text('${service['category'] ?? 'Consultation available'}', style: const TextStyle(fontSize: 10, color: Colors.black54)),
          ])),
          const Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.black26),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final services = (data['services'] as List? ?? []).cast<Map>();
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(slivers: [
              SliverAppBar(
                floating: true,
                title: const Text('FURLESS', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w900)),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline_rounded)),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                sliver: SliverList.list(children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0A3147), Color(0xFF0D5966), Color(0xFF14B8AE)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: Color(0x260A3147), blurRadius: 32, offset: Offset(0, 16))],
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('FURLESS DIGITAL EXPERIENCE', style: TextStyle(color: Color(0xFF9BF1E9), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.6)),
                      const SizedBox(height: 8),
                      const Text('Discover. Book.\nTrack your journey.', style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w900, height: 1.02)),
                      const SizedBox(height: 10),
                      const Text('A premium mobile experience for consultations, proposals, payments and service updates.', style: TextStyle(color: Color(0xFFD9F0F0), fontSize: 11, height: 1.45)),
                      const SizedBox(height: 16),
                      Row(children: [
                        Expanded(child: FilledButton(onPressed: enquire, style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0A3147), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: const Text('Book Consultation'))),
                        const SizedBox(width: 9),
                        Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white38), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: const Text('My Journey'))),
                      ]),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: _Quick(icon: Icons.auto_awesome_rounded, title: 'Services', sub: 'Explore')),
                    const SizedBox(width: 8),
                    Expanded(child: _Quick(icon: Icons.calendar_month_rounded, title: 'Bookings', sub: 'Consult')),
                    const SizedBox(width: 8),
                    Expanded(child: _Quick(icon: Icons.payments_outlined, title: 'Payments', sub: 'Status')),
                    const SizedBox(width: 8),
                    Expanded(child: _Quick(icon: Icons.chat_bubble_outline_rounded, title: 'Support', sub: 'Chat')),
                  ]),
                  const SizedBox(height: 20),
                  const Text('Featured Services', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: Color(0xFF0A3147))),
                  const SizedBox(height: 10),
                  if (services.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFD9E8EB))),
                      child: const Text('Service catalogue will load from the Furless Odoo backend.', style: TextStyle(color: Colors.black54)),
                    )
                  else
                    ...services.take(6).map((s) => Padding(padding: const EdgeInsets.only(bottom: 8), child: serviceCard(s))),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFEAF9F7), Color(0xFFEEF3FF)]),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFD9E8EB)),
                    ),
                    child: const Row(children: [
                      CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.verified_rounded, color: Color(0xFF14B8AE))),
                      SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('One connected journey', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0A3147))),
                        SizedBox(height: 3),
                        Text('Consultation → proposal → acceptance → payment → service updates', style: TextStyle(fontSize: 9.5, color: Colors.black54, height: 1.35)),
                      ])),
                    ]),
                  ),
                ]),
              ),
            ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'Services'),
          NavigationDestination(icon: Icon(Icons.check_circle_outline_rounded), label: 'Journey'),
          NavigationDestination(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }
}

class _Quick extends StatelessWidget {
  const _Quick({required this.icon, required this.title, required this.sub});
  final IconData icon;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 7),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFD9E8EB))),
        child: Column(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFFEAF8F7), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF14B8AE), size: 18)),
          const SizedBox(height: 7),
          Text(title, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF0A3147))),
          Text(sub, style: const TextStyle(fontSize: 7.5, color: Colors.black45)),
        ]),
      );
}

class EnquirySheet extends StatefulWidget {
  const EnquirySheet({super.key, required this.api});
  final Api api;
  @override
  State<EnquirySheet> createState() => _E();
}

class _E extends State<EnquirySheet> {
  final n = TextEditingController(), p = TextEditingController(), e = TextEditingController(), m = TextEditingController();
  bool busy = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(18, 8, 18, MediaQuery.of(context).viewInsets.bottom + 18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('New Consultation Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0A3147))),
          const SizedBox(height: 12),
          TextField(controller: n, decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 8),
          TextField(controller: p, decoration: const InputDecoration(labelText: 'Mobile')),
          const SizedBox(height: 8),
          TextField(controller: e, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 8),
          TextField(controller: m, minLines: 3, maxLines: 4, decoration: const InputDecoration(labelText: 'How can we help?')),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: busy
                ? null
                : () async {
                    setState(() => busy = true);
                    await widget.api.enquiry({'name': n.text, 'phone': p.text, 'email': e.text, 'message': m.text});
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enquiry submitted successfully')));
                    }
                  },
            child: Text(busy ? 'Submitting...' : 'Submit Enquiry'),
          ),
        ]),
      );
}

import 'package:farmvilla/EmptyCart.dart';
import 'package:flutter/material.dart';

// final ProductController controller = Get.put(ProductController());
const qty = 6;
int total = 300;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "My cart",
      ),
    );
  }

  Widget cartListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: qty,
      itemBuilder: (_, index) {
        // Product product = controller.cartProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 234, 247)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/Raju.jpg",
                      width: 43,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Raju bhaiya",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      "raju bhai ki jay ho",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '$total',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 23),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                    const Text(
                      '1',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget bottomBarTitle() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            Text(
              "\$$total",
              key: ValueKey<int>(total),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color(0xFFEC6813),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarButton() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: ElevatedButton(
            child: const Text("Buy Now"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: qty > 0 ? cartListView() : const EmptyCart(),
          ),
          bottomBarTitle(),
          bottomBarButton()
        ],
      ),
    );
  }
}

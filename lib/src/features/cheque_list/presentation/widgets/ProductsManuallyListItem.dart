import 'package:flutter/material.dart';
import 'package:tally_up/src/features/cheque_list/domain/models/ProductModel.dart';

class ProductManuallyListItem extends StatefulWidget {
  final Product product;

  const ProductManuallyListItem({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductManuallyListItemState createState() =>
      _ProductManuallyListItemState();
}

class _ProductManuallyListItemState extends State<ProductManuallyListItem> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController controller = TextEditingController();
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 10),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                onChanged: (newName) {
                  setState(() {
                    widget.product.setName(newName);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Color(0xFF0079FF),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.product.quantity.value--;
                      });
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: widget.product.quantity,
                    builder: (context, int quantity, _) {
                      return Text(widget.product.quantity.value.toString());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xFF0079FF),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.product.quantity.value++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: ValueListenableBuilder(
              valueListenable: widget.product.quantity,
              builder: (context, int quantity, _) {
                controller.text = "${widget.product.getFinelPrice()} РУБ";
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 90,
                      height: 50,
                      alignment: Alignment.centerRight,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          text = text.replaceAll(' РУБ', '');
                          widget.product.price = double.tryParse(text) ?? 0.0;
                        },
                      ),
                    ));
              }),
        )
      ],
    );
  }
}

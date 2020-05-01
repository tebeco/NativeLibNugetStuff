#[no_mangle]
pub extern fn do_stuff(num: i32) -> i32 {
	println!("Native function do_stuff called with argument {:?}", num);
	num * num
}

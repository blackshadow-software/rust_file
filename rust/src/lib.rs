pub mod functions;
pub mod models;
use std::{time::Duration, usize};

#[no_mangle]
pub extern "C" fn sum(a: usize, b: usize) -> usize {
    a + b
}

#[no_mangle]
pub extern "C" fn sum_long_running(a: usize, b: usize) -> usize {
    std::thread::sleep(Duration::from_secs(5));
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = sum(2, 2);
        assert_eq!(result, 4);
    }
}

// #[no_mangle]
// pub extern "C" fn fast_copy(src: *const c_char, dest: *const c_char) -> *const c_char {
//     let src = unsafe { std::ffi::CStr::from_ptr(src) };
//     let dest = unsafe { std::ffi::CStr::from_ptr(dest) };
//     let src = src.to_str().unwrap();
//     let dest = dest.to_str().unwrap();
//     println!("src: {}, dest: {}", src, dest);
//     src.as_ptr() as *const c_char
// }

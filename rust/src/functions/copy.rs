use crate::models::model::Response;
use libc::c_char;
use std::ffi::CString;

#[no_mangle]
pub extern "C" fn fast_copy(src: *const c_char, dest: *const c_char) -> *const c_char {
    let src = unsafe { std::ffi::CStr::from_ptr(src) };
    let src = src.to_str().unwrap();
    let dest = unsafe { std::ffi::CStr::from_ptr(dest) };
    let dest = dest.to_str().unwrap();

    let r = Response::success();
    let r = r.to_json();
    let r = r.as_str();
    let c_string = CString::new(r).unwrap();
    c_string.into_raw()
}

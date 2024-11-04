use crate::models::model::Response;
use anyhow::{bail, Result};
use libc::c_char;
use rayon::iter::{ParallelBridge, ParallelIterator};
use std::{
    ffi::CString,
    fs,
    path::{Path, PathBuf},
};
use walkdir::WalkDir;

#[no_mangle]
pub extern "C" fn fast_copy(src: *const c_char, dest: *const c_char) -> *const c_char {
    let src = unsafe { std::ffi::CStr::from_ptr(src) };
    let src = src.to_str().unwrap();
    let dest = unsafe { std::ffi::CStr::from_ptr(dest) };
    let dest = dest.to_str().unwrap();

    let response: Response;
    match copy(src, dest) {
        Ok(_) => response = Response::success(),
        Err(e) => response = Response::error(e.to_string().as_str()),
    }

    let r = response.to_json();
    let r = r.as_str();
    let c_string = CString::new(r).unwrap();
    c_string.into_raw()
}

fn copy(src_: &str, dest_: &str) -> Result<()> {
    println!("src {:?} & dest {:?}", src_, dest_);

    let src = PathBuf::from(src_);
    let dest = PathBuf::from(dest_);

    if !src.exists() {
        bail!("Source path does not exist");
    }

    match src.is_dir() {
        true => copy_dir(&src, &dest),
        false => copy_file(&src, &dest),
    }
}

fn copy_file(src: &PathBuf, dest: &PathBuf) -> Result<()> {
    if !dest.exists() {
        fs::File::create(dest.clone())?;
        println!("Created File: {:?}", dest);
    }

    fs::copy(src, dest)?;

    Ok(())
}

fn copy_dir(src_: &PathBuf, dest_: &PathBuf) -> Result<()> {
    if !dest_.exists() {
        fs::create_dir_all(dest_)?;
    }

    _ = WalkDir::new(src_)
        .into_iter()
        .par_bridge()
        .filter_map(Result::ok)
        .filter(|e| e.path().is_dir())
        .for_each(|entry| {
            let src = entry.path();
            println!("src: {:?}", src);
            let s_ = src.strip_prefix(src_).unwrap();
            println!("s_: {:?}", s_);
            let mut dst = dest_.clone();
            if !s_.eq(Path::new("")) {
                dst = dst.join(s_);
            }
            if let Err(e) = fs::create_dir_all(&dst) {
                println!("Error creating directory: {}", e);
            }
        });

    println!("\nCreated all directories under {:?}", dest_);

    WalkDir::new(src_)
        .into_iter()
        .par_bridge()
        .filter_map(Result::ok)
        .filter(|e| e.path().is_file())
        .try_for_each(|entry| {
            let src = entry.path();
            println!("src: {:?}", src);
            let s_ = src.strip_prefix(src_).unwrap();
            println!("s_: {:?}", s_);
            let mut dst = dest_.clone();
            if !s_.eq(Path::new("")) {
                dst = dst.join(s_);
            }
            println!("Copying {:?} to {:?}", src, dst);
            fs::copy(&src, &dst)?;
            Ok(())
        })
}
// pub fn copy_dir(src: &Path, dst: &Path) -> Result<()> {
//     if !dst.exists() {
//         fs::create_dir_all(dst)?;
//     }

//     _ = WalkDir::new(src)
//         .into_iter()
//         .par_bridge()
//         .filter_map(Result::ok)
//         .filter(|e| e.path().is_dir())
//         .for_each(|entry| {
//             let src = entry.path();
//             let dst = dst.join(src.strip_prefix(src).unwrap());
//             if let Err(e) = fs::create_dir_all(&dst) {
//                 log::error!("Error creating directory: {}", e);
//             }
//         });

//     WalkDir::new(src)
//         .into_iter()
//         .par_bridge()
//         .filter_map(Result::ok)
//         .filter(|e| e.path().is_file())
//         .try_for_each(|entry| {
//             let src = entry.path();
//             let dst = dst.join(src.strip_prefix(src)?);
//             fs::copy(&src, &dst)?;
//             Ok(())
//         })
// }

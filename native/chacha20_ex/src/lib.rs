#[macro_use] extern crate rustler;

use rustler::{Encoder, Env, Error, Term};
use chacha20::{ChaCha20, ChaCha12, ChaCha8, Key, Nonce};
use chacha20::cipher::{NewCipher, StreamCipher};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        atom key_size_error;
        atom nonce_size_error;
    }
}

rustler::rustler_export_nifs! {
    "Elixir.Chacha20",
    [
        ("run_chacha20", 3, run_chacha20),
        ("run_chacha12", 3, run_chacha12),
        ("run_chacha8", 3, run_chacha8),
    ],
    None
}

fn run_chacha20<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let data: Vec<u8> = args[0].decode()?;
    let key: Vec<u8> = args[1].decode()?;
    let nonce: Vec<u8> = args[2].decode()?;

    if key.len() != 32 {
        return Ok((atoms::error(), atoms::key_size_error()).encode(env))
    }

    if nonce.len() != 12 {
        return Ok((atoms::error(), atoms::nonce_size_error()).encode(env))
    }

    let mut data = data.clone();
    let key = Key::from_slice(&key);
    let nonce = Nonce::from_slice(&nonce);

    // create cipher instance
    let mut cipher = ChaCha20::new(&key, &nonce);

    // apply keystream (encrypt)
    cipher.apply_keystream(&mut data);

    Ok((atoms::ok(), data).encode(env))
}

fn run_chacha12<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let data: Vec<u8> = args[0].decode()?;
    let key: Vec<u8> = args[1].decode()?;
    let nonce: Vec<u8> = args[2].decode()?;

    if key.len() != 32 {
        return Ok((atoms::error(), atoms::key_size_error()).encode(env))
    }

    if nonce.len() != 12 {
        return Ok((atoms::error(), atoms::nonce_size_error()).encode(env))
    }

    let mut data = data.clone();
    let key = Key::from_slice(&key);
    let nonce = Nonce::from_slice(&nonce);

    // create cipher instance
    let mut cipher = ChaCha12::new(&key, &nonce);

    // apply keystream (encrypt)
    cipher.apply_keystream(&mut data);

    Ok((atoms::ok(), data).encode(env))
}

fn run_chacha8<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let data: Vec<u8> = args[0].decode()?;
    let key: Vec<u8> = args[1].decode()?;
    let nonce: Vec<u8> = args[2].decode()?;

    if key.len() != 32 {
        return Ok((atoms::error(), atoms::key_size_error()).encode(env))
    }

    if nonce.len() != 12 {
        return Ok((atoms::error(), atoms::nonce_size_error()).encode(env))
    }

    let mut data = data.clone();
    let key = Key::from_slice(&key);
    let nonce = Nonce::from_slice(&nonce);

    // create cipher instance
    let mut cipher = ChaCha8::new(&key, &nonce);

    // apply keystream (encrypt)
    cipher.apply_keystream(&mut data);

    Ok((atoms::ok(), data).encode(env))
}

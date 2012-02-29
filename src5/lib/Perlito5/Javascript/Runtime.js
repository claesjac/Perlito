//
// lib/Perlito5/Javascript/Runtime.js
//
// Runtime for "Perlito" Perl5-in-Javascript
//
// AUTHORS
//
// Flavio Soibelmann Glock  fglock@gmail.com
//
// COPYRIGHT
//
// Copyright 2009, 2010, 2011, 2012 by Flavio Soibelmann Glock and others.
//
// This program is free software; you can redistribute it and/or modify it
// under the same terms as Perl itself.
//
// See http://www.perl.com/perl/misc/Artistic.html

if (typeof NAMESPACE !== 'object') {
    NAMESPACE = {};
    CLASS = {};

    var universal = function () {};
    CLASS.UNIVERSAL = new universal();
    CLASS.UNIVERSAL._ref_ = 'UNIVERSAL';
    CLASS.UNIVERSAL.isa = function (List__) {
        return List__[0]._class_._ref_ == List__[1]
    };
    CLASS.UNIVERSAL.can = function (List__) {
        var o = List__[0];
        var s = List__[1];
        if ( s.indexOf('::') == -1 ) {
            return o._class_[s]
        }
        var c = s.split('::');
        s = c.pop(); 
        return CLASS[c.join('::')][s]
    };
    CLASS.UNIVERSAL.DOES = CLASS.UNIVERSAL.can;

    NAMESPACE.UNIVERSAL = new universal();

    var core = function () {};
    CLASS.CORE = new core();
    CLASS.CORE._ref_ = 'CORE';

    NAMESPACE.CORE = new core();
}

function make_package(pkg_name) {
    if (!CLASS.hasOwnProperty(pkg_name)) {
        var tmp = function () {};
        tmp.prototype = CLASS.UNIVERSAL;
        CLASS[pkg_name] = new tmp();
        CLASS[pkg_name]._ref_ = pkg_name;
        CLASS[pkg_name]._class_ = CLASS[pkg_name];  // XXX memory leak

        var tmp = function () {};
        tmp.prototype = NAMESPACE.CORE;
        NAMESPACE[pkg_name] = new tmp();
    }
}

function make_sub(pkg_name, sub_name, func) {
    NAMESPACE[pkg_name][sub_name] = CLASS[pkg_name][sub_name] = func;
}

if (typeof arguments === 'object') {
    List_ARGV = arguments;
}

function HashRef(o) {
    this._hash_ = o;
    this._ref_ = 'HASH';
    this.bool = function() { return 1 };
}

function ArrayRef(o) {
    this._array_ = o;
    this._ref_ = 'ARRAY';
    this.bool = function() { return 1 };
}

function ScalarRef(o) {
    this._scalar_ = o;
    this._ref_ = 'SCALAR';
    this.bool = function() { return 1 };
}

make_package('IO');
make_package('Perlito5::Runtime');
make_package('Perlito5::Grammar');

make_sub('IO', 'slurp', function(List__) {
    var filename = List__[0];
    if (typeof readFile == 'function') {
        return readFile(filename);
    }
    if (typeof read == 'function') {
        // v8
        return read(filename);
    }
    CLASS.CORE.die(["IO.slurp() not implemented"]);
});

interpolate_array = function() {
    var res = [];
    for (i = 0; i < arguments.length; i++) {
        var o = arguments[i];
        if  (  o == null
            || o._class_    // perl5 blessed reference
            || o._ref_      // perl5 un-blessed reference
            )
        {
            res.push(o);
        }
        else if (o instanceof Array) {
            // perl5 array
            for (j = 0; j < o.length; j++) {
                res.push(o[j]);
            }
        }
        else if (typeof o === 'object') {
            // perl5 hash
            for(var j in o) {
                if (o.hasOwnProperty(j)) {
                    res.push(j);
                    res.push(o[j]);
                }
            }
        }
        else {
            // non-ref
            res.push(o);
        }
    }
    return res;
};

array_to_hash = function(a) {
    var res = {};
    for (i = 0; i < a.length; i+=2) {
        res[string(a[i])] = a[i+1];
    }
    return res;
};

string = function(o) {
    if (o == null) {
        return "";
    }
    if (typeof o === 'object' && (o instanceof Array)) {
        var out = [];
        for (var i = 0; i < o.length; i++) {
            out.push(string(o[i]));
        }
        return out.join(" ");
    }
    if (typeof o.string === 'function') {
        return o.string();
    }
    if (typeof o !== 'string') {
        return "" + o;
    }
    return o;
};

num = function(o) {
    if (o == null) {
        return 0;
    }
    if (typeof o === 'object' && (o instanceof Array)) {
        return o.length;
    }
    if (typeof o.num === 'function') {
        return o.num();
    }
    if (typeof o !== 'number') {
        return parseFloat(string(o));
    }
    return o;
};

add = function(o1, o2) {
    return num(o1) + num(o2)
};

bool = function(o) {
    if (o == null) {
        return o;
    }
    if (typeof o === 'boolean') {
        return o;
    }
    if (typeof o === 'number') {
        return o;
    }
    if (typeof o === 'string') {
        return o != '' && o != '0';
    }
    if (typeof o.bool === 'function') {
        return o.bool();
    }
    if (typeof o.length === 'number') {
        return o.length;
    }
    for (var i in o) {
        return true;
    }
    return false;
};

and = function(a, fb) {
    if (bool(a)) {
        return fb();
    }
    return a;
};

or = function(a, fb) {
    if (bool(a)) {
        return a;
    }
    return fb();
};

defined_or = function(a, fb) {
    if (a == null) {
        return fb();
    }
    return a;
};

str_replicate = function(o, n) {
    n = num(n);
    return n ? Array(n + 1).join(o) : "";
};

make_sub('Perlito5::Grammar', 'word', function(List__) {
    var v_grammar = List__[0];
    var v_str     = List__[1];
    var v_pos     = List__[2];
    return NAMESPACE.CORE.bless([
        new HashRef({
            str: v_str,
            from: v_pos,
            to: v_pos + 1,
            bool: v_str.substr(v_pos, 1).match(/\w/) != null,
        }),
        CLASS['Perlito5::Match']
    ]);
});

make_sub('Perlito5::Grammar', 'digit', function(List__) {
    var v_grammar = List__[0];
    var v_str     = List__[1];
    var v_pos     = List__[2];
    return NAMESPACE.CORE.bless([
        new HashRef({
            str:  v_str,
            from: v_pos,
            to:   v_pos + 1,
            bool: v_str.substr(v_pos, 1).match(/\d/) != null,
        }),
        CLASS['Perlito5::Match']
    ]);
});

make_sub('Perlito5::Grammar', 'space', function(List__) {
    var v_grammar = List__[0];
    var v_str     = List__[1];
    var v_pos     = List__[2];
    return NAMESPACE.CORE.bless([
        new HashRef({
            str:  v_str,
            from: v_pos,
            to:   v_pos + 1,
            bool: v_str.substr(v_pos, 1).match(/\s/) != null,
        }),
        CLASS['Perlito5::Match']
    ]);
});

function perl5_to_js( source ) {
    // say( "source: [" + source + "]" );
    match = CLASS['Perlito5::Grammar'].exp_stmts([CLASS['Perlito5::Grammar'], source, 0]);

    ast = NAMESPACE.CORE.bless([
        new HashRef({
            block:  NAMESPACE.CORE.bless([
                        new HashRef({
                            stmts:   match._class_.flat([match]),
                        }),
                        CLASS['Perlito5::AST::Lit::Block']
                    ]),
        }),
        CLASS['Perlito5::AST::Do']
    ]);

    // CORE.say( "ast: [" + perl(ast) + "]" );
    js_code = ast._class_.emit_javascript([ast]);
    // CORE.say( "js-source: [" + js_code + "]" );
    return js_code;
}


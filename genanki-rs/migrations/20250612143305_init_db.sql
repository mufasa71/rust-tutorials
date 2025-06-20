-- sqlfluff:dialect:sqlite

CREATE TABLE col (
    id integer PRIMARY KEY AUTOINCREMENT,
    crt integer NOT NULL,
    mod integer NOT NULL,
    scm integer NOT NULL,
    ver integer NOT NULL,
    dty integer NOT NULL,
    usn integer NOT NULL,
    ls integer NOT NULL,
    conf text NOT NULL,
    models text NOT NULL,
    decks text NOT NULL,
    dconf text NOT NULL,
    tags text NOT NULL
);
CREATE TABLE notes (
    id integer PRIMARY KEY AUTOINCREMENT,
    guid text NOT NULL,
    mid integer NOT NULL,
    mod integer NOT NULL,
    usn integer NOT NULL,
    tags text NOT NULL,
    flds text NOT NULL,
    sfld integer NOT NULL,
    csum integer NOT NULL,
    flags integer NOT NULL,
    data text NOT NULL
);
CREATE TABLE cards (
    id integer PRIMARY KEY AUTOINCREMENT,
    nid integer NOT NULL,
    did integer NOT NULL,
    ord integer NOT NULL,
    mod integer NOT NULL,
    usn integer NOT NULL,
    type integer NOT NULL,
    queue integer NOT NULL,
    due integer NOT NULL,
    ivl integer NOT NULL,
    factor integer NOT NULL,
    reps integer NOT NULL,
    lapses integer NOT NULL,
    "left" integer NOT NULL,
    odue integer NOT NULL,
    odid integer NOT NULL,
    flags integer NOT NULL,
    data text NOT NULL
);
CREATE TABLE revlog (
    id integer PRIMARY KEY AUTOINCREMENT,
    cid integer NOT NULL,
    usn integer NOT NULL,
    ease integer NOT NULL,
    ivl integer NOT NULL,
    lastivl integer NOT NULL,
    factor integer NOT NULL,
    time integer NOT NULL,
    type integer NOT NULL
);
CREATE TABLE graves (
    usn integer NOT NULL,
    oid integer NOT NULL,
    type integer NOT NULL
);
CREATE INDEX ix_notes_usn ON notes (usn);
CREATE INDEX ix_cards_usn ON cards (usn);
CREATE INDEX ix_revlog_usn ON revlog (usn);
CREATE INDEX ix_cards_nid ON cards (nid);
CREATE INDEX ix_cards_sched ON cards (did, queue, due);
CREATE INDEX ix_revlog_cid ON revlog (cid);
CREATE INDEX ix_notes_csum ON notes (csum);
